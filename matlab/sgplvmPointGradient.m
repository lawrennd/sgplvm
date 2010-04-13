function g = sgplvmPointGradient(x,model,Y,comps)

g = zeros(1,model.q);
for(i = 1:1:length(comps))
  g = g + fgplvmPointGradient(x,model.comp{comps(i)},Y{i});
end

return