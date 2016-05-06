function [ population ] = SelectBestPopulationElements( population, maxAmount )
%SELECTNESTPOPULATIONELEMENTS Summary of this function goes here
% Select best k (maxAmount) models from population according to the model errors
%
% Inputs:
% population - cell array of models;
% maxAmount - number k of top-k models
%
% Outputs:
% population - cell array of top-k models
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013
%

handles = cellfun(@(x)x.Handle, population,'UniformOutput', false);
[~,indsToRetrieve,~] = unique(handles);
handles = handles(indsToRetrieve);
population = population(indsToRetrieve);


indsToRetrieve = strfind(handles,'ln_([],ex');
indsToRetrieve = cellfun(@(x) isempty(x), indsToRetrieve );
population = population(indsToRetrieve==1);
handles = handles(indsToRetrieve==1);

indsToRetrieve = strfind(handles,'expl_([],ln');
indsToRetrieve = cellfun(@(x) isempty(x), indsToRetrieve );
population = population(indsToRetrieve==1);
handles = handles(indsToRetrieve==1);

indsToRetrieve = strfind(handles,'expl_([],expl_([],ex');
indsToRetrieve = cellfun(@(x) isempty(x), indsToRetrieve );
population = population(indsToRetrieve==1);
handles = handles(indsToRetrieve==1);

errors = cellfun(@(x)x.Error, population);
[~, sortedIdcs] = sort(errors);
population = population(sortedIdcs(1 : min(maxAmount, length(population))));

end

