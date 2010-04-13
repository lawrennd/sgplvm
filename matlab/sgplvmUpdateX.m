function model = sgplvmUpdateX(model,X);

model.X = X;
for(i = 1:1:model.numModels)
      model.comp{1}.X = X;
end

return