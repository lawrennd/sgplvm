function model = sgplvmCreateFromLatent(generative_id,X,Y,options_fgplvm,options_sgplvm)

latent_dim = size(X,2);
model = cell(size(generative_id,1),1);
for(i = 1:1:length(model))
  options_fgplvm.initX = X;
  model{i} = fgplvmCreate(latent_dim,size(Y{i},2),Y{i},options_fgplvm);
  model{i}.X = X;
end

options_sgplvm.initX = false.*ones(size(generative_id,1),latent_dim);
options_sgplvm.initX(1,:) = true;
model = sgplvmCreate(model,[],options_sgplvm);

return;