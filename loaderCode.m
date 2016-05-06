function [matMetaData, matDocIdStr, matDocRanks, matTermDocVars, vecDelim] = loaderCode(matDocRanks, idQ, numbQ,trecs)
%loaderCode 
% Loader retrieves the information given by the java_launcher.m module for
% one query specified by numbQ
% 
%
% Inputs:
% numbQ    - identifiers of the query in integer format
% 
% Outputs:
% matDocRanks    - expert-given judgements
% matDocIdStr    - linkers between document ids and their string representation
% matTermDocVars - matrix with parameters specified in 1.4.4 in sysdocs for
%                  every  term
% vecDelim       - vector with number of documents corresponding to terms
%                  of query
%
%
% Course: Machine Learning and Data Analysis
% Supervisor: A.P.Motrenko
% Author: A. Kulunchakov
% Date 8.12.2014



FILE_METADATA        = ['metadata',num2str(trecs),'.txt'];
FILE_TERM_DOC_VARS   = ['Data',num2str(trecs),'/termvars',int2str(numbQ),'.txt'];
FILE_DOC_ID_STR      = ['Data',num2str(trecs),'/doc_id_strings',int2str(numbQ),'.txt'];
FILE_DELIM_TERMVARS  = ['Data',num2str(trecs),'/lengthForTerms',int2str(numbQ),'.txt'];

matFileDocIdStr = fopen(FILE_DOC_ID_STR);
matFileMetadata = fopen(FILE_METADATA);



%retrieve data from files

matDocIdStr           = textscan(matFileDocIdStr, '%s%d', 'delimiter', ' '); %relation between name of the doc and its id used in the index of the collection
matMetaData           = textscan(matFileMetadata, '%s%d', 'delimiter', ' '); %metadata about the collection
indsToRetrieve = matDocRanks{1}==idQ;
for ii=1:4 
    matDocRanks{ii}  = matDocRanks{ii}(indsToRetrieve);
end
% matTermDocvars: matrix nx3, every row contains information about
% retrieved document:
% 1. Document Id
% 2. Term Frequency in the document
% 3. Document length
% All variables are integers


matTermDocVars        = dlmread(FILE_TERM_DOC_VARS);
vecDelim              = dlmread(FILE_DELIM_TERMVARS);
before = length(matTermDocVars(:,1));
%disp(['occurances before sparsing  = ', num2str(sum(vecDelim))])
% There comes the sparsing
% ==================== SPARSING =========================
% Eliminate all occurances in matrices which are not in the expert ranks

namesDocs = matDocRanks{3};
indsToRetrieve = ismember(matDocIdStr{1}, namesDocs);


% matDocIdStr sparsing
for ii = 1:length(matDocIdStr)
    matDocIdStr{ii} = matDocIdStr{ii}(indsToRetrieve);
end

indsToRetrieve = matDocIdStr{2};

matTermDocVarsCopy = ones(1,0);
vecDelimCopy       = ones(1,length(vecDelim));

start = 0;


for jj = 1:length(vecDelim)
    sliceToWorkWith = matTermDocVars(start+1:start+vecDelim(jj),:);
    vecFromSlice = sliceToWorkWith(:,1);
    indsToRemain = ismember(vecFromSlice,indsToRetrieve);
    indsToRemain = find(indsToRemain==1);
    sliceToWorkWith = sliceToWorkWith(indsToRemain,:);
    matTermDocVarsCopy = [matTermDocVarsCopy; sliceToWorkWith];
    vecDelimCopy(jj) = length(indsToRemain);
    start = start + vecDelim(jj);
end
matTermDocVars = matTermDocVarsCopy;
vecDelim       = vecDelimCopy';

%fclose('all');

fopen([FILE_TERM_DOC_VARS],'w');
matFileDocIdStr = fopen([FILE_DOC_ID_STR],'w');
fopen([FILE_DELIM_TERMVARS],'w');


dlmwrite([FILE_TERM_DOC_VARS], matTermDocVars,'delimiter',' ','precision', 6);
dlmwrite([FILE_DELIM_TERMVARS], vecDelim,'delimiter','\n','precision', 6);

v1 = matDocIdStr{1};
v2 = matDocIdStr{2};

for ii = 1:length(matDocIdStr{1})
    str = v1(ii);
    
    fprintf(matFileDocIdStr,'%s %d\n',str{1},v2(ii));
end
%disp(['occurances after sparsing  = ', num2str(sum(vecDelim))])
fclose('all');

after = length(matTermDocVars(:,1));

    
if before~=after
    disp(num2str(idQ));
    disp(FILE_TERM_DOC_VARS);
    fprintf('remained documents: %.3f\n',double(after)*100/before);
end


