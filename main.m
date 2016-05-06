function [ ] = main(PrjFname)

warning off
SWITCHER = 'cross-mute';

% number of trec to learn on
trecs = 7;

%java_launcher();
%finalSparsing(FILE_QUERIES);
[primitives, models, genopt, matDocRanks] = addpather(trecs);
[~, matDocRanks, matQueries, modelCharacteristics] = loaderData(matDocRanks,trecs);

population = CreateRandomPopulation(3, primitives, 2, 3);
population = LearnPopulation(population, matDocRanks, matQueries, modelCharacteristics);

numbGenerModels = 0;

matOfNorms1 = zeros(0);
matOfNorms2 = zeros(0);
matOfNorms3 = zeros(0);

matOfTimes1 = zeros(0);
matOfTimes2 = zeros(0);
matOfTimes3 = zeros(0);
matOfLength = zeros(0);
tic
if strcmp(SWITCHER,'cross-mute') == 1
    for itr = 1 : genopt.MAXCYCLECOUNT
        itr

        populationCO = CrossoverPopulation(population, genopt.CROSSINGAMOUNT);
        populationCO = LearnPopulation(populationCO , matDocRanks, matQueries, modelCharacteristics);
        populationMU = MutationPopulation(population, primitives, 2, genopt.MUTATIONAMOUNT);
        populationMU = LearnPopulation(populationMU , matDocRanks, matQueries, modelCharacteristics);
        
        population = [population, populationCO, populationMU];
        numbGenerModels = numbGenerModels + length(population);
        
        population = SelectBestPopulationElements(population, genopt.BESTELEMAMOUNT);
        
        timeElapsed = toc;
        
        fprintf('Number of generated models: %d\nElapsed time: %d\nPerfomance: %.1f models per sec.\n',numbGenerModels,timeElapsed,double(numbGenerModels)/timeElapsed);
        PrintPopulation(population);
        
        
        if mod(itr,20)==0
            
            [vecN, timeElapsed] = metrVecs(population, 1);
            matOfNorms1 = [matOfNorms1, vecN];
            matOfTimes1 = [matOfTimes1, timeElapsed];
            
            [vecN, timeElapsed] = metrVecs(population, 2);
            matOfNorms2 = [matOfNorms2, vecN];
            matOfTimes2 = [matOfTimes2, timeElapsed];
            
            [vecN, timeElapsed] = metrVecs(population, 3);
            matOfNorms3 = [matOfNorms3, vecN];
            matOfTimes3 = [matOfTimes3, timeElapsed];
            
            lengths = cellfun(@(x) length(x.Tokens), population);
            matOfLength = [matOfLength, mean(lengths)];
        end
        
        if (matOfNorms2 < ThreshholdForMetric)
            
            indecesToRemove = round(length(population)/2):length(population);
            populationSub = CreateRandomPopulation(length(indecesToRemove), primitives, 2, 6);
            populationSub = LearnPopulation(populationSub , matDocRanks, matQueries, modelCharacteristics);
            population(indecesToRemove) = populationSub;
            
        end
        
    end;
else
    for itr = 1 : genopt.MAXCYCLECOUNT
        itr
        populationAdder = CreateRandomPopulation([25,20,20,10], primitives, 2, [4,3,5,6]);
        populationAdder = LearnPopulation(populationAdder ,matDocRanks, matQueries, modelCharacteristics);
        population = [population, populationAdder];
        numbGenerModels = numbGenerModels + length(population);
        
        PrintPopulation(population);
        population = SelectBestPopulationElements(population, genopt.BESTELEMAMOUNT);
        disp('==================================================');
        fprintf('\nThe best model for this iteration:\nHandle = %s;\nError = %.3f\n',population{1}.Handle,-population{1}.Error);
        timeElapsed = toc;
        
        fprintf('Number of generated models: %d\nElapsed time: %d\nPerfomance: %.1f models per sec.\n',numbGenerModels,timeElapsed,double(numbGenerModels)/timeElapsed);
    end
end

dlmwrite('report/norms.txt', [matOfNorms1;matOfNorms2;matOfNorms3;matOfLength],'delimiter',' ','precision', 3);



fprintf('Handle = %s;\nError = %d\n',population{1}.Handle,-population{1}.Error);
outputFile = fopen('templ3.txt','a+');
timeElapsed = toc;
fprintf('Elapsed time = %d',timeElapsed);

fclose(outputFile);


end
