function [matMetaData, matDocIdStr, matDocRanks, matTermDocVars, vecDelim] = sparser(matMetaData, matDocIdStr, matDocRanks, matTermDocVars, vecDelim,numbQ) 
    %files with data retrieved by Terrier
    THISFOLDER = fileparts(mfilename('fullpath'));
    DATAFOLDER = fullfile(THISFOLDER,'Data');
    addpath(DATAFOLDER);
    
    FILE_QUERIES = 'queries-res.txt';
    
    FILE_DOC_RANKS       = 'ranks_little.txt';
    FILE_METADATA        = 'metadata.txt';
    FILE_TERM_DOC_VARS   = ['termvars',int2str(numbQ),'.txt'];
    FILE_DOC_ID_STR      = ['doc_id_strings',int2str(numbQ),'.txt'];
    FILE_DELIM_TERMVARS  = ['lengthForTerms',int2str(numbQ),'.txt'];
    
    matFileDocRanks = fopen(FILE_DOC_RANKS);
    matFileDocIdStr = fopen(FILE_DOC_ID_STR);
    matFileMetadata = fopen(FILE_METADATA);
    matFileQueries = fopen(FILE_QUERIES);
    matQueries     = textscan(matFileQueries, '%d%s', 'delimiter', '#'); 
    
   
    [matMetaData, matDocIdStr, matDocRanks, matTermDocVars, vecDelim] = loaderData();
    
    matDocRanks{1}
end