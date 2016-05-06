function [] = LensPopulation (population)

lenspop = ones(1, length(population));
for ii = 1:length(population)
    model = population{ii};
    lenspop(ii) = length(model.Tokens);
    
end


end