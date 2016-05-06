function [ tex ] = Model2Tex( model, tokIdx)
%MODEL2TEX
% Creates tex string for a model using information of the .tex field of the
% structure
%
% Inputs:
% model
%
% Outputs:
% tex - tex representation string
% tokIdx - current token index
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

% If a variable - return
children = find(model.Mat(tokIdx, :));
if isempty(children)
    tex = model.Tex{tokIdx};
    return
end

% Initialize tex by a primitive version
tex = model.Tex{tokIdx};

[variables] = regexp(tex, '(x\d*)', 'tokens');
variables = cellfun(@(x)x{1}, variables, 'UniformOutput', false);
uniqueVariables = unique(variables);

if length(children) ~= length(uniqueVariables)
    error('Something wrong in model tex representation') % Fixme !!
end

for varIdx = 1 : length(uniqueVariables)
    tex = regexprep(tex, uniqueVariables(varIdx), Model2Tex(model, children(varIdx)));
end


end

