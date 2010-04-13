function f = sgplvmPointObjective(x,model,Y,comps)

f = 0;
for(i = 1:1:length(comps))
  f = f + fgplvmPointObjective(x,model.comp{comps(i)},Y{i});
end

return