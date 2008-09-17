clear all close all;

% 1. Set types
sgplvm_model_type = 'back1';%'standard';
data_type = 'rand';
nr_iters = 3;

% 2. Load Data
switch data_type
 case 'rand'
  Y_train = rand(100,30);
  Z_train = rand(100,10);
  Ky = Y_train*Y_train';
  Kz = Z_train*Z_train';
  seq = [4 13 100];
 otherwise
  error('Unkown Data Type');
end

% 3. Learn Initialisation through NCCA
[Xsy Xsz Xy Xz] = nccaEmbed(Ky,Kz,[60 85],uint8(1),[40 95],true);

Xs = (1/2).*(Xsy+Xsz);
X_init = [Xy Xs Xz];
X_init = (X_init-repmat(mean(X_init),size(X_init,1),1))./repmat(std(X_init),size(X_init,1),1);

% 4. Create SGPLVM model
switch sgplvm_model_type
 case 'standard'
  options_y = fgplvmOptions('fitc');
  options_y.optimiser = 'scg';
  options_y.scale2var1 = true;
  options_y.initX = X_init;
  
  model{1} = fgplvmCreate(size(options_y.initX,2),size(Y_train,2),Y_train,options_y);
  model{1} = sgplvmSetLatentDimension(model{1},'gen',[1:1:size([Xy Xs],2)],true);
    
  options_z = fgplvmOptions('fitc');
  options_z.optimiser = 'scg';
  options_z.scale2var1 = true;
  options_z.initX = X_init;
  
  model{2} = fgplvmCreate(size(options_z.initX,2),size(Z_train,2),Z_train,options_z);
  model{2} = sgplvmSetLatentDimension(model{2},'gen',[size(Xy,2)+1:1:size(X_init,2)],true);
 
  options = sgplvmOptions;
  options.save_intermediate = inf;
  options.name = 'sgplvm_ncca_test_';
  options.initX = zeros(2,size(X_init,2));
  options.initX(1,:) = true;
  options.initX(2,:) = false;
  
  model = sgplvmCreate(model,[],options);
 case 'dynamic'
  options_y = fgplvmOptions('fitc');
  options_y.optimiser = 'scg';
  options_y.scale2var1 = true;
  options_y.initX = X_init;
  
  model{1} = fgplvmCreate(size(options_y.initX,2),size(Y_train,2),Y_train,options_y);
  model{1} = sgplvmSetLatentDimension(model{1},'gen',[1:1:size([Xy Xs],2)],true);
    
  options_z = fgplvmOptions('fitc');
  options_z.optimiser = 'scg';
  options_z.scale2var1 = true;
  options_z.initX = X_init;
  
  model{2} = fgplvmCreate(size(options_z.initX,2),size(Z_train,2),Z_train,options_z);
  model{2} = sgplvmSetLatentDimension(model{2},'gen',[size(Xy,2)+1:1:size(X_init,2)],true);
 
  options = sgplvmOptions;
  options.save_intermediate = inf;
  options.name = 'sgplvm_ncca_test_';
  options.initX = zeros(2,size(X_init,2));
  options.initX(1,:) = true;
  options.initX(2,:) = false;

  model = sgplvmCreate(model,[],options);

  model = sgplvmAddDynamics(model,'gp',[size(Xy,2)+1:1:size(X_init,2)],[size(Xy,2)+1:1:size(X_init,2)],X_init,gpOptions('ftc'),1,1,seq);
  
 case 'back1'
  options_y = fgplvmOptions('fitc');
  options_y.optimiser = 'scg';
  options_y.scale2var1 = true;
  options_y.initX = X_init;
  options_y.back = 'kbr';
  options_y.backOptions.kern = kernCreate(Y_train,'rbf');
  options_y.backOptions.X = Y_train;
  options_y.backOptions.kern.inverseWidth = 3e-1;
  options_y.optimiseInitBack = true;
  
  model{1} = fgplvmCreate(size(options_y.initX,2),size(Y_train,2),Y_train,options_y);
  model{1} = sgplvmSetLatentDimension(model{1},'gen',[1:1:size([Xy Xs],2)],true);
  model{1} = sgplvmSetLatentDimension(model{1},'back',[size(Xy,2)+1:1:size([Xy Xs],2)],true);
  
  options_z = fgplvmOptions('fitc');
  options_z.optimiser = 'scg';
  options_z.scale2var1 = true;
  options_z.initX = X_init;
  options_z.backOptions.kern = kernCreate(Z_train,'rbf');
  options_z.backOptions.X = Z_train;
  options_z.backOptions.kern.inverseWidth = 2;
  options_z.optimiseInitBack = true;
  
  model{2} = fgplvmCreate(size(options_z.initX,2),size(Z_train,2),Z_train,options_z);
  model{2} = sgplvmSetLatentDimension(model{2},'gen',[size(Xy,2)+1:1:size(X_init,2)],true);
 
  options = sgplvmOptions;
  options.save_intermediate = inf;
  options.name = 'sgplvm_ncca_test_';
  options.initX = zeros(2,size(X_init,2));
  options.initX(1,:) = true;
  options.initX(2,:) = false;

  model = sgplvmCreate(model,[],options);

  model = sgplvmAddDynamics(model,'gp',[size(Xy,2)+1:1:size(X_init,2)],[size(Xy,2)+1:1:size(X_init,2)],X_init,gpOptions('ftc'),1,1,seq);
  
  
 otherwise
  error('Unkown SGPLVM Type');
end

% 5. Train SGPLVM model
model = sgplvmOptimise(model,true,nr_iters,false,false);

keep('model');