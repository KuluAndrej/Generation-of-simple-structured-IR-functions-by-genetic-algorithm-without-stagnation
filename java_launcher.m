function []  = java_launcher()
%java_launcher 
% Method for communicating with java-machine for retrieving information
% about given collection of documents and forming parameters described in
% systemdocs in 1.4.4
% 
%

% Inputs:
% [empty]
%
% Outputs:
% [empty]   
% 
% Course: Machine Learning and Data Analysis
% Supervisor: A.P.Motrenko
% Author: A. Kulunchakov
% Date 8.12.2014
clear all
trecs = [5];
length(trecs)
for jj = 1:length(trecs)

    FILE_QUERIES = ['queriesS',num2str(trecs(jj)),'.txt'] ;
    THISFOLDER = fileparts(mfilename('fullpath'));
    DATAFOLDER = fullfile(THISFOLDER,'Data');
    DATAFOLDER2 = fullfile(THISFOLDER,'data');
    addpath(DATAFOLDER);
    addpath(DATAFOLDER2);

    matFileQueries = fopen(FILE_QUERIES);
    matQueries   = textscan(matFileQueries, '%d%s', 'delimiter', '#'); 

    uniteString = ['trec',num2str(trecs(jj)),'#']
    for ii=1:length(matQueries{1})-1
        str = matQueries{2}(ii);
        uniteString = [uniteString, str{1}, '#'];
    end
    str = matQueries{2}(length(matQueries{1}));

    uniteString = [uniteString, str{1}];

    %HERE COMES THE JAVA CLASS

    TermVarsJC = TestTermVariables(['trec', num2str(trecs(jj))],length(matQueries{1}));
    disp('loaded')
    javaMethod('main', TermVarsJC, uniteString)
    disp('start replacing')
    
    numdocs = length(matQueries{1});
    constanta = matQueries{1}(1)-1;
    
    for ii=1:numdocs
        movefile(['Data/lengthForTerms',num2str(ii),'.txt'],['Data',num2str(trecs(jj)),'/lengthForTerms',num2str(ii+constanta),'.txt']);
    end
    beep
    for ii=1:numdocs
        movefile(['Data/termvars',num2str(ii),'.txt'],['Data',num2str(trecs(jj)),'/termvars',num2str(ii+constanta),'.txt']);
    end
    for ii=1:numdocs
        movefile(['Data/doc_id_strings',num2str(ii),'.txt'],['Data',num2str(trecs(jj)),'/doc_id_strings',num2str(ii+constanta),'.txt']);
    end
    
    %replacer(trecs(jj));
    disp('retrieval is done')
    
    %finalSparsing(FILE_QUERIES);
end
end