function [qualValue] = totalQuality_Ext(model1, model2, matDocRanks, matQueries, modelCharacteristics)
%totalQuality 
% Returns total quality value of the given function according to a set of
% user's queries
% 
%
% Inputs:
% Function - function in a string form, 
%
% Outputs:
% value - double value - quality of the function
% 
% Course: Machine Learning and Data Analysis
% Supervisor: A.P.Motrenko
% Author: A. Kulunchakov
% Date 8.12.2014
Function1 = str2func(model1.Handle());
Function2 = str2func(model2.Handle());

vecQualities = ones(1,length(matQueries{1}));
for ii=1:length(matQueries{1})
    [matDocRel1] = evaluation(Function1, modelCharacteristics{ii}, ii);
    [matDocRel2] = evaluation(Function2, modelCharacteristics{ii}, ii);
    vecQualities(ii) = quality_Ext(matQueries{1}(ii), matDocRel1, matDocRel2, matDocRanks{ii},ii);
end

qualValue = mean(vecQualities);

model1.Error = -qualValue;
model1.Rank = qualValue;

