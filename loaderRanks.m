function [matDocRanks] = loaderRanks(trecs)

THISFOLDER = fileparts(mfilename('fullpath'));
DATAFOLDER = fullfile(THISFOLDER,'Data');
addpath(DATAFOLDER);

FILE_DOC_RANKS       = ['ranks',num2str(trecs),'.txt'];
matFileDocRanks      =  fopen(FILE_DOC_RANKS);
matDocRanks           = textscan(matFileDocRanks, '%d%d%s%d', 'delimiter', ' '); %binary ranks for some of the collection documents

end