function [ subModel ] = ExtractSubModel( model, vertexIdx )
%EXTRACTSUBMODEL
% The function extracts submodel from an initial model
%
% Inputs:
% model - initial model structure
% vertexIdx - index of a token which must be a root of the extracted model
%
% Outputs:
% subModel - extracted submodel (subtree)
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

% Extract submodel according to the Depth-First-Search method
[extractedIdcs, subModel.Mat] = DFSExtract(model, vertexIdx, [], [], 0);

% Update submodel parameters
subModel.Tokens = model.Tokens(extractedIdcs);
subModel.ParamNums = model.ParamNums(extractedIdcs);
subModel.InitParams = model.InitParams(extractedIdcs);
subModel.ParDom = model.ParDom(extractedIdcs);
subModel.ArgDom = model.ArgDom(extractedIdcs);
subModel.Tex = model.Tex(extractedIdcs);
% Update submodel handle
subModel = UpdateModelHandle(subModel);

end

function [extractedIdcs, extractedTree, parentIdx] = DFSExtract(model, vertexIdx, ...
    extractedIdcs, extractedTree, parentIdx)
% DFSEXTRACT
% Depth-First-Search method for extracting submodel

extractedIdcs(end + 1) = vertexIdx;
if isempty(extractedTree)
    extractedTree = 0;
else
    extractedTree(end + 1, :) = zeros(1, size(extractedTree, 2));
    extractedTree(:, end + 1) = zeros(size(extractedTree, 1), 1);
    extractedTree(parentIdx, end) = 1;
end;
parentIdx = length(extractedIdcs);
children = find(model.Mat(vertexIdx, :));
for childIdx = 1 : length(children)
    [extractedIdcs, extractedTree] = DFSExtract(model, children(childIdx), ...
        extractedIdcs, extractedTree, parentIdx);
end

end

