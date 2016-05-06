function [ paramNums, initParams, parDom, argDom, tex ] = ReturnPrimitivesInfo( modelMat, modelTokens, primitives )
%RETURNPRIMITIVESINFO
% return information about primitives used in a model:
% number of parameters, initial parameters, parameters domain, arguments domain
%
% Inputs:
% modelMat - n-by-n matrix of a model where n is a number of tokens;
% modelTokens - n-by-1 cell array of tokens names; token names are primitives or variable names;
% primitives - p-by-1 cell array of primitives
%
% Outputs:
% paramNums - number of parameters;
% initParams - initial parameters;
% ParDom - parameters domain;
% ArgDom - arguments domain
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

paramNums = zeros(length(modelTokens), 1);
initParams = cell(length(modelTokens), 1);
parDom = cell(length(modelTokens), 1);
argDom = cell(length(modelTokens), 1);
tex = cell(length(modelTokens), 1);
for tokenIdx = 1 : length(paramNums)
    if any(modelMat(tokenIdx, :)) % If a function
       
        [~, modelLoc] = ismember(modelTokens{tokenIdx}, cellfun(@(x)x.Name, primitives, 'UniformOutput', false));
        if ~modelLoc
            error(strcat(['Token ', char(modelTokens{tokenIdx}), ' is not a member of registry']));
        end;
        
        paramNums(tokenIdx) = primitives{modelLoc}.NumParams;
        currentParams = primitives{modelLoc}.InitParams;
        
        if length(currentParams) ~= paramNums(tokenIdx)
            warning(['Defalut params are not-well defined for the token ', modelTokens{tokenIdx}{1}]);
            
            currentParams = zeros(1, length(paramNums));
        end;
        initParams{tokenIdx} = currentParams;
        parDom{tokenIdx} = primitives{modelLoc}.ParDom;
        argDom{tokenIdx} = primitives{modelLoc}.ArgDom;
        tex{tokenIdx} = primitives{modelLoc}.Tex;
    else % If a variable
        paramNums(tokenIdx) = 0;
        initParams{tokenIdx} = [];
        parDom{tokenIdx} = [];
        argDom{tokenIdx} = [];
        currTok = char(modelTokens{tokenIdx});
        tex{tokenIdx} = strcat(currTok(1), '_', currTok(2 : end));
    end;
end;

end

