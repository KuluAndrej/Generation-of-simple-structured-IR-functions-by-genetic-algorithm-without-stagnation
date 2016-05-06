function [ model ] = CreateModelByString( modelString, primitives, initParams )
%CREATEMODELBYSTRING 
% Creates model structure using model in a string form, cell array of
% primitives and array of initial parameters for the model
%
% Inputs:
% modelStr - model in a string form,
% primitives - P-by-1 cell array of all primitives,
% initParams - m-by-1 array of initial parameters for the model
%
% Outputs:
% model - a structure with the following fields:
%  model.Mat - n-by-n superposition connections matrix, obtained by the function
%   CreateMatByString, where n is a numer of tokens;
%  model.Tokens - n-by-1 cell array of tokens used in a model, obtained by
%   the function CreateMatByString;
%  model.InitParams - n-by-1 cell array of initial parameters for each
%   token;
%  model.ParamNums - n-by-1 array of parameters number fo each token;
%  model.ParDom - n-by-1 cell array of parameters domain;
%  model.ArgDom - n-by-1 cell array of arguments domain;
%  model.Handle - anonymous function string
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

% Initialize model fields
model.Name = modelString;
[model.Mat, model.Tokens] = CreateMatByString(modelString);
% Return information about primitives
[paramNums, defaultParams, model.ParDom, model.ArgDom, model.Tex] = ReturnPrimitivesInfo(model.Mat, model.Tokens, primitives);
initParams = str2num(initParams);
if length(initParams) ~= sum(paramNums)
    warning(['Length of init params vector does not equal to number of parameters for the model ', modelString])
    model.InitParams = defaultParams;
else
    model.InitParams = cell(length(paramNums), 1);
    cellIdcs = find(paramNums);
    paramIdcs = [0; cumsum(paramNums(cellIdcs))];
    for paramIdx = 2 : length(paramIdcs)
        model.InitParams{cellIdcs(paramIdx - 1)} = initParams(paramIdcs(paramIdx - 1) + 1 : paramIdcs(paramIdx));
    end
end

model.ParamNums = paramNums;
% Initialize model handle and re-calculate model fields according to the
% handle order
model = UpdateModelHandle(model);

end

