function ll = sgplvmLogLikelihood(model)

% SGPLVMLOGLIKELIHOOD Log-likelihood for a sGP-LVM.
% FORMAT
% DESC Returns the log likelihood for the given sgplvm model
% ARG model : sgplvm model
% RETURN ll : log likelihood of given sgplvm model
%
% SEEALSO : fgplvmLogLikelihood, sgplvmCreate
%
% COPYRIGHT : Neil D. Lawrence, Carl Henrik Ek, 2007, 2009

% SGPLVM

ll = 0;

% 1. gp
for(i = 1:1:model.numModels)
  ll = ll + gpLogLikelihood(model.comp{i});
end
% 2. latent prior
if(isfield(model,'dynamics')&&~isempty(model.dynamics))
  % dynamic prior
  for(i = 1:1:model.dynamics.numModels)
    if(isfield(model.dynamics.comp{i},'balancing'))
      balancing = model.dynamics.comp{i}.balancing;
    else
      balancing = 1;
    end
    ll = ll + balancing*modelLogLikelihood(model.dynamics.comp{i});
  end
  % find dimensions with no dynamic prior
  non_dyn_dim = [];
  for(i = 1:1:model.q)
    ind = find(model.dynamic_id(:,i));
    if(isempty(ind))
      non_dyn_dim = [non_dyn_dim i];
    end
  end
  if(~isempty(non_dyn_dim))
    % find generative models with input from non_dyn_dim
    gen_model_id = find(model.generative_id(:,non_dyn_dim));
    [gen_model_id void] = ind2sub(size(model.generative_id(:,non_dyn_dim)),gen_model_id);
    gen_model_id = unique(gen_model_id)';
    for(i = 1:1:length(gen_model_id))
      if(isfield(model.comp{gen_model_id(i)},'prior')&&~isempty(model.comp{gen_model_id(i)}))
	dim = find(model.generative_id(gen_model_id(i),:));
	dim = intersect(dim,non_dyn_dim);
	for(j = 1:1:model.N)
	  ll = ll + priorLogProb(model.comp{gen_model_id(i)}.prior,model.X(j,dim));
	end
      end
    end
  end
else
  % no dynamic
  for(i = 1:1:model.numModels)
    if(isfield(model.comp{i},'prior')&&~isempty(model.comp{i}.prior))
      for(j = 1:1:model.N)
	dim = find(model.generative_id(i,:));
	ll = ll + priorLogProb(model.comp{i}.prior,model.X(j,dim));
      end
    end
  end
end
% 3. sparse approximation
for(i = 1:1:model.numModels)
  switch model.comp{i}.approx
   case {'dtc','fitc','pitc'}
    if(isfield(model.comp{i},'inducingPrior')&&~isempty(model.comp{i}.inducingPrior))
      for(j = 1:1:model.comp{i}.k)
	ll = ll + priorLogProb(model.comp{i}.inducingPrior, model.comp{i}.X_u(j,:));
      end
    end
   otherwise
  end
end

% 4. constraint
if(isfield(model,'constraints')&&~isempty(model.constraints))
  for(i = 1:1:model.constraints.numConstraints)
    ll = ll - constraintLogLikelihood(model.constraints.comp{i},model.X);
  end
end