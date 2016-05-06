function [ model ] = CreateRandomModel( primitives, numTotalVariables, numPrimitives )
%CREATERANDOMMODEL
% Creates model structure using array of primitives, total variables number
% and desired number of primitives in a model
%
% Inputs:
% primitives - P-by-1 cell array of all primitives;
% numTotalVariables total number of variables;
% numPrimitives - desired number of primitives in a model
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

% Generate primitives randomly
primitiveIdcs = randi(length(primitives), numPrimitives, 1);
usedPrimitives = primitives(primitiveIdcs);
% Calculate number of variables as number of "opened" primitive vertices
numVariables = sum(cellfun(@(x)x.Nargmax, usedPrimitives)) - length(usedPrimitives) + 1;
% Generate used variables randomly
usedVariables = randi(numTotalVariables, numVariables, 1);
% Create tokens corresponding to the variables
varTokens = strcat('x',  arrayfun(@num2str, usedVariables, 'UniformOutput', false));
model.Tokens = [cellfun(@(x)x.Name, usedPrimitives, 'UniformOutput', false); varTokens];

% Initialize funcMat - superposition graph matrix
funcMat = zeros(numPrimitives + numVariables);
% Calculate funcMat
currStartIdx = 2;
for prIdx = 1 : numPrimitives      
    currEndIdx = currStartIdx + usedPrimitives{prIdx}.Nargmax - 1;
    funcMat(prIdx, currStartIdx : currEndIdx) = 1;
    currStartIdx = currEndIdx + 1;
end

%Initialize model fields
model.Mat = funcMat;
model.Name = ''; % Fixit
model.InitParams = [cellfun(@(x)x.InitParams, usedPrimitives, 'UniformOutput', false); ...
    cell(numVariables, 1)];
model.ParamNums = [cellfun(@(x)x.NumParams, usedPrimitives); zeros(numVariables, 1)];
model.ParDom = [cellfun(@(x)x.ParDom, usedPrimitives, 'UniformOutput', false); cell(numVariables, 1)];
model.ArgDom = [cellfun(@(x)x.ArgDom, usedPrimitives, 'UniformOutput', false); cell(numVariables, 1)];
model.Tex = [cellfun(@(x)x.Tex, usedPrimitives, 'UniformOutput', false); ...
    cellfun(@(x)strcat(x(1), '_', x(2:end)), varTokens, 'UniformOutput', false)];
% Initialize model handle and re-calculate model fields according to the
% handle order
model = UpdateModelHandle(model);

end
