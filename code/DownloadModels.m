function [ models, initParams ] = DownloadModels( ModelsFullFname )
%DOWNLOADMODELS
% Download model names (strings) and initial parameters from file
%
% Inputs:
% ModelsFullFname - full filename
%
% Outputs:
% models - strings of model names;
% initParams - strings of model initial parameters
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

fid = fopen(ModelsFullFname);

if fid < 0
    error('Wrong Models filename');
end

models = textscan(fid,'%s%s','CommentStyle','%','Delimiter',';');
initParams = models{2};
models = models{1};

end
