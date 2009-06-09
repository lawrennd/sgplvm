function dim = sgplvmGetDimension(model,type,model_id)

if(strcmp(type,'private')&&nargin<3)
  error('Need to specify model id');
end
if(nargin<3)
  model_id = [];
end


dim = [];
switch type
 case 'shared'
  if(isempty(model_id)||length(model_id)==1)
    % Return dimensions shared by all models
    for(i = 1:1:model.q)
      if(length(find(model.generative_id(:,i)))==model.numModels)
        dim = [dim i];
      end
    end
  else
    % Return dimensions shared by model_id models
    for(i = 1:1:model.q)
      if(length(find(model.generative_id(model_id,i)))==length(model_id))
        dim = [dim i];
      end
    end
  end
 case 'private'
  for(i = 1:1:model.q)
    tmp = find(model.generative_id(:,i));
    if(length(tmp)==1&&tmp==model_id)
      dim = [dim i];
    end
  end
 case 'generative'
  dim = find(model.generative_id(model_id,:));
end

return;