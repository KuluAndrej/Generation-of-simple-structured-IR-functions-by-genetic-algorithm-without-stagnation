function [ model ] = UpdateModelHandle( model )
%CREATEMODELHANDLE Create model handle using
%Depth-First-Search method; reorder model components according to DFS
%
% Inputs:
% model
%
% Outputs:
% model with "Handle" field and updated other fields
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013
%
funcStack = 1; % Create stack for Depth-First-Search, as root to stack
nonViewedNodes = ones(size(model.Mat, 1), 1);
nonViewedNodes(1) = 0;
currentBeginParam = 1;
newOrder = 1;

handle = '@(w,x)'; % Initialize handle string

if ~any(model.Mat(1, :)) % If first token is a variable then return
    varNum = regexp(char(model.Tokens{1}), '(\d*)', 'tokens');
    handle = [handle, 'x(:,', char(varNum{1}), ')'];
    model.Handle = handle;
    model.Mat = 0;
    model.Tokens = model.Tokens(1);
    model.InitParams = model.InitParams(1);
    model.ParamNums = model.ParamNums(1);
    model.ArgDom = model.ArgDom(1);
    model.ParDom = model.ParDom(1);  
    model.Tex = model.Tex(1); 
    return
end

% Initialize hahdle string with the first token
handle = [handle, char(model.Tokens{1})]; 
handle = [handle, '('];
if model.ParamNums(1) ~= 0
    handle = [handle, 'w(', int2str(currentBeginParam), ':', ...
        int2str(currentBeginParam + model.ParamNums(1) - 1), '),'];
else
    handle = [handle, '[],'];
end;

currentBeginParam = currentBeginParam + model.ParamNums(1);

while ~isempty(funcStack)
    currentNodeIdx = funcStack(end);
    currentNodeChildren = find(model.Mat(currentNodeIdx, :));
    q = find(nonViewedNodes);
    
    nonViewedChildren = ismembc2(currentNodeChildren, q);
    
    nonViewedChildren = nonViewedChildren(find(nonViewedChildren));
    nonViewedChildren = q(nonViewedChildren);
    
    if ~isempty(nonViewedChildren)
        if length(currentNodeChildren) ~= length(nonViewedChildren)
            handle = [handle, ','];
        end;
        newOrder(end + 1) = nonViewedChildren(1);
        nextChild = nonViewedChildren(1);
        nonViewedNodes(nextChild) = 0;
        if any(model.Mat(nextChild, :)) % If next node is a function, not a variable
            handle = [handle, char(model.Tokens{nextChild}), '('];
            if model.ParamNums(nextChild) ~= 0
                handle = [handle, 'w(', int2str(currentBeginParam), ':', ...
                    int2str(currentBeginParam + model.ParamNums(nextChild) - 1), '),'];
                currentBeginParam = currentBeginParam + model.ParamNums(nextChild);
            else
                handle = [handle, '[],'];
            end;
            funcStack(end + 1) = nextChild;
        else
            varNum = regexp(char(model.Tokens{nextChild}), '(\d*)', 'tokens');
            handle = [handle, 'x(:,', char(varNum{1}), ')'];
        end;
    else
        handle = [handle, ')'];
        funcStack(end) = [];
    end;
end;
% Update other model fields according to the new order
model.Handle = handle;
model.Mat = model.Mat(newOrder, newOrder);
model.Tokens = model.Tokens(newOrder);
model.InitParams = model.InitParams(newOrder);
model.ParamNums = model.ParamNums(newOrder);
model.ArgDom = model.ArgDom(newOrder);
model.ParDom = model.ParDom(newOrder);
model.Tex = model.Tex(newOrder);

end

