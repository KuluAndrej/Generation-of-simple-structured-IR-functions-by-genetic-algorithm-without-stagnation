% Function for testing empirical hypothesis about introduced 
% structural metrics. This hypothesis is described as 4th condition
% (see attached scientific paper)

function [ ] = main_checker(PrjFname)

warning off
SWITCHER = 'cross-mute';

trecs = 7;

[primitives, models, genopt, matDocRanks] = addpather(trecs);
[~, matDocRanks, matQueries, modelCharacteristics] = loaderData(matDocRanks,trecs);


populationSize = 20;
numTotalVariables = 2;
matCompMetr1 = zeros(20,2);
matCompMetr2 = zeros(20,2);
matCompMetr3 = zeros(20,2);
tic
for numPrimitives =3:4
    fprintf('numPrimitives = %d\n',numPrimitives );
     
    population = CreateRandomPopulation(populationSize, primitives, numTotalVariables,  numPrimitives);
    qualValue = LearnPopulation_Ext(population, matDocRanks, matQueries, modelCharacteristics);
        
    matCompMetr1 = cellFiller(population, matCompMetr1, qualValue, 1);
    matCompMetr2 = cellFiller(population, matCompMetr2, qualValue, 2);
    matCompMetr3 = cellFiller(population, matCompMetr3, qualValue, 3);
    
end
toc
for qq = 1:20
    if (matCompMetr1(qq,2)~=0)
        matCompMetr1(qq,1) = matCompMetr1(qq,1)/matCompMetr1(qq,2);
    end
    if (matCompMetr2(qq,2)~=0)
        matCompMetr2(qq,1) = matCompMetr2(qq,1)/matCompMetr2(qq,2);
    end
    if (matCompMetr3(qq,2)~=0)
        matCompMetr3(qq,1) = matCompMetr3(qq,1)/matCompMetr3(qq,2);
    end
end

writeInFile = [matCompMetr1';matCompMetr2';matCompMetr3'];
disp('first')
disp(matCompMetr1(:,1)')
disp('second')
disp(matCompMetr2(:,1)')
disp('third')
disp(matCompMetr3(:,1)')




end
