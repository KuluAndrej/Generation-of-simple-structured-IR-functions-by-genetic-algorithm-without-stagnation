function [ structMat, tokens ] = CreateMatByString( modelStr )
%CREATEMATBYSTRING 
% Creates superposition graph connection matrix using model in a string
% form
%
% Inputs:
% modelStr - model in a string form, 
%
% Outputs:
% structMat - n-by-n graph matrix, where n is a tokens number
% tokens - n-by-1 cell array of function/variable names obtained by parsing modelStr
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

% Parse input string on tokens; regexp is simply '([\w]*)'

[tokens, tokenStartIdcs, tokenEndIdcs] = regexp(modelStr, '([\w]*)', 'tokens');
tokens = tokens';
if isempty(tokens)
    error('Empty model')
end
% Find indices corresponding to begin of function tokens
[~, funcStartIdcs] = regexp(modelStr, '([\w]+)[\s]*(', 'tokens');
% Find indices corresponding to close brackets
closeBracketIdcs = strfind(modelStr, ')');

% Initialize matrix and stack for DFS analogue
structMat = zeros(length(tokens));
funcStack = 1;
funcCounter = 1;
while ~isempty(funcStack)
    funcCounter = funcCounter + 1;
    structMat(funcStack(end), funcCounter) = 1;
    if any(tokenStartIdcs(funcCounter) == funcStartIdcs) % If next child is a function
        funcStack(end + 1) = funcCounter;
    else % If next child is a variable
        if funcCounter == length(tokens) 
            funcStack = []; % the end
        else
            popFuncNumber = length(find(all([closeBracketIdcs > tokenEndIdcs(funcCounter); ...
                closeBracketIdcs < tokenStartIdcs(funcCounter + 1)]))); % Number of function to be popped from stack
            funcStack(end - popFuncNumber + 1 : end) = [];
        end;
    end;
end;
end

