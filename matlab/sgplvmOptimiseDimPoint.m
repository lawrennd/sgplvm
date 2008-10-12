function X = sgplvmOptimiseDimPoint(model,X,dim,display,iters)

% SGPLVMOPTIMISEDIMPOINT Optimise subspace of point
% FORMAT
% DESC Takes a model and a latent location 

% SGPLVM
  
if(nargin<5)
  iters = 100;
  if(nargin<4)
    display = 0;
    if(nargin<3)
      error('Too Few Arguments');
    end
  end
end

