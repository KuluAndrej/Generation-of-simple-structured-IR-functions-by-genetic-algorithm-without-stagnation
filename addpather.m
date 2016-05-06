function [primitives, models, genopt, matDocRanks] = addpather(trecs)

PrjFname = 'demo.prj.txt';

THISFOLDER = fileparts(mfilename('fullpath'));
DATAFOLDER = fullfile(THISFOLDER,'data');
DATFOLDER3 = fullfile(THISFOLDER,'Data3');
DATFOLDER5 = fullfile(THISFOLDER,'Data5');
DATFOLDER6 = fullfile(THISFOLDER,'Data6');
DATFOLDER7 = fullfile(THISFOLDER,'Data7');
DATFOLDER8 = fullfile(THISFOLDER,'Data8');
FUNCFOLDER = fullfile(THISFOLDER,'func');
CODEFOLDER = fullfile(THISFOLDER,'code');
SELFFOLDER = fullfile(THISFOLDER,'self');

addpath(FUNCFOLDER);
addpath(CODEFOLDER);
addpath(DATFOLDER3);
addpath(DATFOLDER5);
addpath(DATFOLDER6);
addpath(DATFOLDER7);
addpath(DATFOLDER8);
addpath(DATAFOLDER);
addpath(SELFFOLDER);



[primitives, models, genopt]  = InputProjectData( PrjFname, DATAFOLDER );
matDocRanks = loaderRanks(trecs);

end