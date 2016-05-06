function [ mutatedModel ] = MutateModel( model, vertexIdx, primitives, numVariables, numPrimitives )
%MUTATEMODEL Summary of this function goes here
% Performs model mutation; can be used in an evolutionary optimum search
%
% Inputs:
% model model struct;
% vertexIdx - index of a subtree (submodel) root which should replaced by a
% random model
% primitives - p-by-1 cell array of primitives, used for random submodel
%  construction
% numVariables - total number of variables
% numPrimitives - number of primitives in a randomly generated submodel
%
% Outputs:
% mutatedModel - model after mutation
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

% First create a random model
mutatedPart = CreateRandomModel(primitives, numVariables, numPrimitives);
% Second replace the submodel by the new randomly generated model
mutatedModel = ReplaceSubModel(model, vertexIdx, mutatedPart);

end

