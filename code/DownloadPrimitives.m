function [ primitives ] = DownloadPrimitives( PrimitivesFullFname )
%DOWNLOADPRIMITIVES
% Download model primitives from file
%
% Inputs:
% PrimitivesFullFname - full filename
%
% Outputs:
% primitives - p-by-1 cell array of primitives
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

fid = fopen(PrimitivesFullFname);
PrimitivesFullFname
if fid < 0
    
    error('Wrong Registry filename');
end
[num, txt] = xlsread(PrimitivesFullFname);
primitives = cell(size(num, 1), 1);

for prIdx = 1 : length(primitives)
    primitive.Name = txt{prIdx + 1, 1};
    primitive.Form = txt{prIdx + 1, 2};
    primitive.Nvecmax = num(prIdx, 1);
    primitive.Nargmax = num(prIdx, 2);
    primitive.NumParams = num(prIdx, 3);
    primitive.ParDom = str2num(txt{prIdx + 1, 6});
    primitive.InitParams = str2num(txt{prIdx + 1, 7});
    primitive.ArgDom = str2num(txt{prIdx + 1, 8});
    primitive.Commute = str2num(txt{prIdx + 1, 9});
    primitive.Cod = str2num(txt{prIdx + 1, 10});
    primitive.Tex = txt{prIdx + 1, 11};
    primitives{prIdx} = primitive;
end

end

