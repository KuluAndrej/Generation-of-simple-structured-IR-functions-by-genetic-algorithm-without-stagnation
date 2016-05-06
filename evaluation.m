function [matDocRel] = evaluation(Function, modelCharacteristics,yy)

%evaluation 
% Returns the vector of the relevance judgements made by our function to
% every document. Also it passes the matrix with expert-given judgements
% and linkers between document ids and their string representation
% 
%
% Inputs:
% TopicName - query in string format
% Function  - function in string format
% numbQ     - identifier of the query in integer format
% limit     - minimum of the terms to occur in the document to call it
%             relevant
% c         - normalization factor for variables
% 
% 
% Outputs:
% 
% matDocRel     - vector of the relevance judgements made by our function
% matDocRanks   - expert-given judgements
% matDocIdStr   - linkers between document ids and their string representation
% 
% 
% Course: Machine Learning and Data Analysis
% Supervisor: A.P.Motrenko
% Author: A. Kulunchakov
% Date 8.12.2014

%disp('enter evaluation');

valuesHandle = Function([],modelCharacteristics{3});


matrDocValues2 = accumarray(modelCharacteristics{2}, valuesHandle,[],@sum);

%{
minimumValue = min(matrDocValues2);
matrDocValues2 = matrDocValues2 - minimumValue + 1;

toZero = isinf(matrDocValues2) | isnan(matrDocValues2);
indsToChange = find(toZero==1);

matrDocValues2(indsToChange) = zeros(length(indsToChange),1);

maximumValue = max(matrDocValues2);

if maximumValue==0
    matrDocValues2 = matrDocValues2./maximumValue;
end
%}
matDocRel = [modelCharacteristics{1}, matrDocValues2]';




%disp(['elapsed time (evaluation) = ', num2str(t)]);