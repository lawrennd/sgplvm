function model = sgplvmOptimiseKernel(model,display,iters)

% 1. Generative models
for(i = 1:1:model.numModels)
  model.comp{i} = gpOptimise(model.comp{i},display,iters);
end

% 2. Dynamic models
if(model.dynamic)
  for(i = 1:1:model.dynamics.numModels)
    model.dynamics.comp{i} = gpOptimise(model.dynamics.comp{i},display, ...
                                        iters);
  end
end

return