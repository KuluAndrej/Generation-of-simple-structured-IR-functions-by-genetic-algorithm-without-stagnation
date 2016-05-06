function [ coModel ] = ReplaceSubModel( model, vertexIdx, subModel )
%REPLACESUBMODEL Summary of this function goes here
% The function replaces one submodel to another
%
% Inputs:
% model - initial model structure
% vertexIdx - index of a token which must be a root of the replaced
% submodel
% subModel - model to replace
%
% Outputs:
% coModel - model with a replaced part
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

    % Check if vertexIdx is root
    if vertexIdx == 1
        coModel = subModel;
        return
    end
    % First remove old submodel having a root indexed by vertexIdx
    [coModel, newVertexIdx] = removeSubModel(model, vertexIdx);
    % Second add new submodel to a "hole"
    coModel = addSubModel(coModel, newVertexIdx, subModel);
    % Update model handle and other parameters
    coModel = UpdateModelHandle(coModel);

end

function [coModel, parentIdx] = removeSubModel(model, vertexIdx)
% Remove  submodel: find "vertexToLeave" - vertices that should be leaved
% in a model. Other vertices should be removed
    parentIdx = find(model.Mat(:, vertexIdx));
    vertexToRemove = vertexIdx;
    vertexList = vertexIdx;
    % DFS; output - vertices to remove
    while ~isempty(vertexList)
        vertexCurrent = vertexList(1);
        vertexList(1) = [];
        vertexList = [vertexList, find(model.Mat(vertexCurrent, :))];
        vertexToRemove = [vertexToRemove, find(model.Mat(vertexCurrent, :))];
    end;
    vertexToLeave = sort(setdiff(linspace(1, length(model.Tokens), length(model.Tokens)), vertexToRemove));
    
    % Update model parameters
    coModel.Mat = model.Mat(vertexToLeave, vertexToLeave);
    coModel.Tokens = model.Tokens(vertexToLeave);
    parentIdx = parentIdx - length(find(vertexToRemove < parentIdx));
    coModel.ParamNums = model.ParamNums(vertexToLeave);
    coModel.InitParams = model.InitParams(vertexToLeave);
    coModel.ParDom = model.ParDom(vertexToLeave);
    coModel.ArgDom = model.ArgDom(vertexToLeave);
    coModel.Tex = model.Tex(vertexToLeave);
end

function [coModel] = addSubModel(coModel, parentIdx, subModel)
% Add submodel function
    % Join model and submodel matrices with "blkdiag" method
    coModel.Mat = blkdiag(coModel.Mat, subModel.Mat);
    % Update model elements
    coModel.Tokens = [coModel.Tokens; subModel.Tokens];
    coModel.Mat(parentIdx, end - size(subModel.Mat, 2) + 1) = 1;
    coModel.ParamNums = [coModel.ParamNums; subModel.ParamNums];
    coModel.InitParams = [coModel.InitParams; subModel.InitParams];
    coModel.ParDom = [coModel.ParDom; subModel.ParDom];
    coModel.ArgDom = [coModel.ArgDom; subModel.ArgDom];
    coModel.Tex = [coModel.Tex; subModel.Tex]; 
end
