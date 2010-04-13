function x = sgplvmOptimisePoint(model,x,Y,display,iters,comps,gradcheck)

if(nargin<7)
  gradcheck = false;
end

options = optOptions;
if(display)
  options(1) = true;
end
if(gradcheck)
  options(9) = true;
end
options(14) = iters;

if isfield(model, 'optimiser')
  optim = str2func(model.optimiser);
else
  optim = str2func('scg');
end

x = optim('sgplvmPointObjective',x,options,'sgplvmPointGradient',model,Y, ...
          comps);

return;