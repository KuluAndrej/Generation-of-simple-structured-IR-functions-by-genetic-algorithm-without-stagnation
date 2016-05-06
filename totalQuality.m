function [model] = totalQuality(model, matDocRanks, matQueries, modelCharacteristics)
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
MAXMODELSIZE = 15;
AMPLITUDE = 0.01;
NODEVIATION = 0.5;


Function = str2func(model.Handle());

vecQualities = ones(1,length(matQueries{1}));
for ii=1:length(matQueries{1})
    str = matQueries{2}(ii);
    [matDocRel] = evaluation(Function, modelCharacteristics{ii},ii);
    vecQualities(ii) = quality(matQueries{1}(ii), matDocRel, matDocRanks{ii},ii);
end

value = sum(vecQualities);
if ~isempty(find(isnan(vecQualities)))
    vecQualities
end
model.Error = -value;
model.Rank = value;
varsNumber = length(find(sum(model.Mat,2)==0));

if length(model.Tokens)>MAXMODELSIZE
    model.Error = -value + value*0.005*(log2(length(model.Tokens)+1))*varsNumber;
end
model.Error = value;
%{
if length(model.Tokens)>MAXMODELSIZE
    model.Error = -value+AMPLITUDE*exp(NODEVIATION*(length(model.Tokens)-MAXMODELSIZE));
else
    model.Error = -value;
end
%}

end

