function model = sgplvmOptimise(model,display,iters,g_check,save_flag)

% SGPLVMOPTIMISE Optimise the SGPLVM.
% FORMAT
% DESC Takes a sgplvm model structure and optimises with respect to
% parameters and latent coordinates
% ARG model : sgplvm model
% ARG display : flag dictating wheter or not to display
% optimisation progress (set to greater than zero) (default = 1)
% ARG iters : maximum number of iterations (default = 2000)
% ARG g_check : Should analytic gradientes be compared with finite
% differences of objective (default = false)
% ARG save_flag : Should final model be saved to disk (default =
% false)
% RETURN model : the optimised model
%
% SEEALSO : sgplvmObjective, sgplvmGradient
%
% COPYRIGHT : Neil D. Lawrence, Carl Henrik Ek, 2007

% SGPLVM

if(nargin<5)
  save_flag = false;
  if(nargin<4)
    g_check = false;
    if(nargin<3)
      iters = 2000;
      if(nargin<2)
	display = true;
	if(nargin<1)
	  error('To Few Arguments');
	end
      end
    end
  end
end
    
global CURRENT_ITERATION;
CURRENT_ITERATION = 0;


params = sgplvmExtractParam(model);
options = optOptions;
if(display)
  options(1) = true;
  if(exist('g_check'))
    options(9) = g_check;
  else
    if(length(params)<= 100)
      options(9) = true;
    end
  end
end
options(14) = iters;

if(isfield(model,'optimiser'))
  if(~isempty(model.optimiser))
    optim = str2func(model.optimiser);
  else
    optim = str2func('scg');
  end
else
  optim = str2func('scg');
end

if strcmp(func2str(optim), 'optimiMinimize')
  % Carl Rasmussen's minimize function 
  params = optim('sgplvmObjectiveGradient', params, options, model);
else
  % NETLAB style optimization.
  params = optim('sgplvmObjective', params,  options, 'sgplvmGradient', model);
end

model = sgplvmExpandParam(model, params);
if(~isfield(model,'iteration')||model.iteration==0)
  model.iteration = CURRENT_ITERATION-1;
else
  model.iteration = model.iteration + CURRENT_ITERATION-1;
end

if(save_flag)
  filename = strcat('model_',model.name,datestr(now),'_iter_',num2str(model.iteration),'FINAL');
  filename(find(isspace(filename)==true)) = '-';
  save(filename,'model');
  fprintf('Save converged model, iteration %d\n',model.iteration);
end

return