function [primitives, models, genopts ] = InputProjectData( prjFname, dataFolder )
%INPUTPROJECTDATA 
% Download data for project from a file
%
% Inputs:
% prjFname - project filename, e.g. 'demo.prj.txt'
% dataFolder - folder with data, models, primitives filenames
%
% Outputs:
% data - data structure:
%  data.X - m-by-n matrix of independent variables,
%  data.Y - m-by-1 vector of target variables;
% primitives - p-by-1 cell array of primitives;
% models - cell array of model name strings;
% nlinopts, genopts, pltopts - options
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

% Initialize default arguments
if nargin < 2
    dataFolder = 'data';
end;

PrjFullFname = fullfile(dataFolder, prjFname);

% read the project file 
evalstr = textread(PrjFullFname,'%s','commentstyle','matlab','delimiter','%');
for i=1:length(evalstr)
    try 
        eval(evalstr{i});   
        fprintf(1,'%s\n',evalstr{i});
    catch
        fprintf(1,'\nError in the project file %s, line = %d, content = %s \n', prjFname, i, evalstr{i});
    end
end 

RegistryFullFname = fullfile(dataFolder, RegistryFile);
ModelsFullFname   = fullfile(dataFolder, ModelsFile);
primitives = DownloadPrimitives(RegistryFullFname);
[models.Models, models.InitParams] = DownloadModels(ModelsFullFname);

genopts.MAXCYCLECOUNT = MAXCYCLECOUNT;
genopts.MAXNUMOFPARAMS = MAXNUMOFPARAMS;
genopts.MAXNUMOFPRIMS = MAXNUMOFPRIMS;
genopts.MUTATIONAMOUNT = MUTATIONAMOUNT;
genopts.BESTELEMAMOUNT = BESTELEMAMOUNT;
genopts.CROSSINGAMOUNT= CROSSINGAMOUNT;
genopt.THRESHOLDQUALITY = THRESHOLDQUALITY;

end

