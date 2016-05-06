function [qualValue] = quality(TopicId, matDocRel, matDocRanks, yy)
%quality 
% Returns quality value of a given function for the given query.
% 
%
% Inputs:
% TopicName - query in string format
% Function  - function in string format
% [TopicId, numbQ]    - identifiers of the query in integer format
% 
%
% Outputs:
% qualValue - quality value in double format
% 
% Course: Machine Learning and Data Analysis
% Supervisor: A.P.Motrenko
% Author: A. Kulunchakov
% Date 8.12.2014

if yy==1
    matDocRel(1,1:min(10, size(matDocRel,2)))
    matDocRel(2,1:min(10, size(matDocRel,2)))
end

vecDocIdEv     = double(matDocRanks{5});
[d1,d2] = sort(matDocRel(1,:));
indsWhichAppear = ismembc(d1,vecDocIdEv);
matDocRel = [matDocRel(:,d2); indsWhichAppear];

[~,d2] = sort(matDocRel(2,:),'descend');
matDocRel = matDocRel(:,d2);


ranksForRetrievedDocs = matDocRel(3,:);
cumRanksForRetrievedDocs = cumsum(ranksForRetrievedDocs);
cutOffPrecision = cumRanksForRetrievedDocs./(1:length(ranksForRetrievedDocs));
qualValue = sum(cutOffPrecision.*ranksForRetrievedDocs)/length(matDocRanks{3});



