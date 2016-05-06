function [ ] = main_checker(PrjFname)

warning off
SWITCHER = 'cross-mute';

trecs = 5;

[primitives, models, genopt, matDocRanks] = addpather(trecs);
[~, matDocRanks, matQueries, modelCharacteristics] = loaderData(matDocRanks,trecs);

populationInit = CreatePopulation(models.Models, models.InitParams, primitives);    
populationInit = LearnPopulation(populationInit, matDocRanks, matQueries, modelCharacteristics);

for jj =1:length(populationInit)
    fprintf([populationInit{jj}.Handle, '\nhas rank = %.3f\n\n'],populationInit{jj}.Rank);
end

for jj=1:10
    disp('===========================')
end

trecs = 6;

[primitives, models, genopt, matDocRanks] = addpather(trecs);
[~, matDocRanks, matQueries, modelCharacteristics] = loaderData(matDocRanks,trecs);
    

tic
populationInit = CreatePopulation(models.Models, models.InitParams, primitives);    
populationInit = LearnPopulation(populationInit, matDocRanks, matQueries, modelCharacteristics);

for jj =1:length(populationInit)
    fprintf([populationInit{jj}.Handle, '\nhas rank = %.3f\n\n'],populationInit{jj}.Rank);
end


for jj=1:10
    disp('===========================')
end

trecs = 7;

[primitives, models, genopt, matDocRanks] = addpather(trecs);
[~, matDocRanks, matQueries, modelCharacteristics] = loaderData(matDocRanks,trecs);


tic
populationInit = CreatePopulation(models.Models, models.InitParams, primitives);    
populationInit = LearnPopulation(populationInit, matDocRanks, matQueries, modelCharacteristics);

for jj =1:length(populationInit)
    fprintf([populationInit{jj}.Handle, '\nhas rank = %.3f\n\n'],populationInit{jj}.Rank);
end


for jj=1:10
    disp('===========================')
end

trecs = 8;

[primitives, models, genopt, matDocRanks] = addpather(trecs);
[~, matDocRanks, matQueries, modelCharacteristics] = loaderData(matDocRanks,trecs);


tic
populationInit = CreatePopulation(models.Models, models.InitParams, primitives);    
populationInit = LearnPopulation(populationInit, matDocRanks, matQueries, modelCharacteristics);

for jj =1:length(populationInit)
    fprintf([populationInit{jj}.Handle, '\nhas rank = %.3f\n\n'],populationInit{jj}.Rank);
end

end
