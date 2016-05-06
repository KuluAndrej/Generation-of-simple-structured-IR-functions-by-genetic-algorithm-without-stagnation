function [] = finalSparsing()
%sparsing 
% For every query in FILEQUERIES erases excessive documents, which contain 
% less than half of the temrs of the corresponding query. 
% We also reserve documents, which
% have very high idf (doc has a high idf according to a term if there are 
% too few documents in the collection with this term.
%
% Inputs:
% FILEQUERIES - file with queries in string format
%
% Outputs:
% [empty]
% 
% Course: Machine Learning and Data Analysis
% Supervisor: A.P.Motrenko
% Author: A. Kulunchakov
% Date 8.12.2014
%FILEQUERIES = 'queries-res.txt';

FILEQUERIES = 'queries.txt';
THISFOLDER = fileparts(mfilename('fullpath'));
DATAFOLDER = fullfile(THISFOLDER,'Data');
addpath(DATAFOLDER);

THISFOLDER = fileparts(mfilename('fullpath'));
DATAFOLDER = fullfile(THISFOLDER,'Data');
addpath(DATAFOLDER);



vecQueries = fopen(FILEQUERIES);
matQueries   = textscan(vecQueries, '%d%s', 'delimiter', '#'); 

numbOfQueries = length(matQueries{1});
for ii=1:numbOfQueries
    ii
    sparsing(ii);
end

end