function [] = sparsing(rangeQ)
%sparsing 
% For specified query erases excessive documents, which  contain less than half
% of the temrs of this query. We also reserve documents, which
% have very high idf (doc has a high idf according to a term if there are 
% too few documents in the collection with this term.
% 
%
% Inputs:
% rangeQ - number of the query in the file with queries, 
%
% Outputs:
% [empty]
% 
% Course: Machine Learning and Data Analysis
% Supervisor: A.P.Motrenko
% Author: A. Kulunchakov
% Date 8.12.2014

THISFOLDER = fileparts(mfilename('fullpath'));
DATAFOLDER = fullfile(THISFOLDER,'Data');
addpath(DATAFOLDER);
%retrieve information about collection for sparsing
%!!! THERE MAY BE PROBLEMS WITH OS: in Windows you should 
%replace '/' with '\' in paths
FILE_TERM_DOC_VARS   = ['Data/termvars',int2str(rangeQ),'.txt'];
FILE_DOC_ID_STR      = ['Data/doc_id_strings',int2str(rangeQ),'.txt'];
FILE_DELIM_TERMVARS  = ['Data/lengthForTerms',int2str(rangeQ),'.txt'];
matFileDocIdStr      = fopen(FILE_DOC_ID_STR);
matDocIdStr          = textscan(matFileDocIdStr, '%s%d', 'delimiter', ' '); %relation between name of the doc and its id used in the index of the collection
fclose(matFileDocIdStr);

matTermDocVars        = dlmread(FILE_TERM_DOC_VARS); 
vecDelim              = dlmread(FILE_DELIM_TERMVARS);

%form the map with number of term-occurences for every document
mapDocId = containers.Map(matTermDocVars(1,1),ones(1));
for jj=2:length(matTermDocVars(:,1))
    if isKey(mapDocId, matTermDocVars(jj,1))==1            
        mapDocId(matTermDocVars(jj,1)) = mapDocId(matTermDocVars(jj,1)) + 1;
    else 
        mapDocId(matTermDocVars(jj,1)) = 1;
    end
end

%Here is the massive code for editing information in the files specified
%above
vecSum                = cumsum(vecDelim); totalSum = sum(vecDelim);
numTerms              = length(vecDelim);

start = 1;

wrFILETERMDOCVARS = fopen(FILE_TERM_DOC_VARS,'w');
wrFILEVECDELIM    = fopen(FILE_DELIM_TERMVARS,'w');

fclose(wrFILEVECDELIM);
fclose(wrFILETERMDOCVARS);
mapOccur = containers.Map(-1,0);

for ii =1:length(vecDelim)
    wrFILEVECDELIM    = fopen(FILE_DELIM_TERMVARS,'at+');
    counter = 0;
    %there we reserve documents with high idf
    if vecDelim(ii)<=totalSum/100
        for jj=start:vecSum(ii)
            wrFILETERMDOCVARS = fopen(FILE_TERM_DOC_VARS,'at+');
            fprintf(wrFILETERMDOCVARS, '%d %d %d\n', matTermDocVars(jj,1), matTermDocVars(jj,2), matTermDocVars(jj,3));
            fclose(wrFILETERMDOCVARS);
            counter = counter + 1;
            mapOccur(matTermDocVars(jj,1)) = 1;
        end
        start = vecSum(ii)+1;
    else 
        %there we reserve information only for documents with specified
        %frequency of terms from query
        for jj = start:vecSum(ii)
            wrFILETERMDOCVARS = fopen(FILE_TERM_DOC_VARS,'at+');
            if isKey(mapDocId, matTermDocVars(jj,1))==1 && mapDocId(matTermDocVars(jj,1))>=floor(numTerms/2)
                fprintf(wrFILETERMDOCVARS, '%d %d %d\n', matTermDocVars(jj,1), matTermDocVars(jj,2), matTermDocVars(jj,3));
                counter = counter + 1;
                mapOccur(matTermDocVars(jj,1)) = 1;
            end
            fclose(wrFILETERMDOCVARS);
        end
        start = vecSum(ii);
    end
    fprintf(wrFILEVECDELIM, '%d\n', counter);
    fclose(wrFILEVECDELIM);    
end

wrFILEDOCSTR      = fopen(FILE_DOC_ID_STR,'w');
fclose(wrFILEDOCSTR);
wrFILEDOCSTR      = fopen(FILE_DOC_ID_STR,'at+');

for ii=1:length(matDocIdStr{1})
    if isKey(mapOccur, matDocIdStr{2}(ii))==1
        str = matDocIdStr{1}(ii);
        fprintf(wrFILEDOCSTR, '%s %d\n', str{1}, matDocIdStr{2}(ii));
    end
end
fclose(wrFILEDOCSTR);


end
