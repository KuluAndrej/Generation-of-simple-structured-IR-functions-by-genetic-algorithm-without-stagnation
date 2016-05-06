function test_suite = test_replacesubmodel( )
initTestSuite;
end

function testNonDFSStructure
mat = zeros(9, 9);
mat(1,7) = 1;
mat(7,9) = 1;
mat(7,5) = 1;
mat(5,6) = 1;
mat(5,8) = 1;
mat(6,4) = 1;
mat(8,3) = 1;
mat(9,2) = 1;
tokens = [{{'root'}}; {{'x1'}}; {{'x2'}}; {{'x1'}}; {{'plus2_'}}; {{'linear_'}}; ...  
    {{'times2_'}}; {{'sin_'}}; {{'sin_'}}];
mdl.Mat = mat;
mdl.Tokens = tokens;
mdl.ParamNums = [0;0;0;0;0;2;0;0;0];
mdl.InitParams = {[];[];[];[];[];[0 1];[];[];[];[]};
mdl.ParDom = {[-Inf, Inf]; []; []; []; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf]};
mdl.ArgDom = {[-Inf, Inf]; []; []; []; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf]};
mdl.Tex = [{{'root(x)'}}; {{'x_1'}}; {{'x_2'}}; {{'x_1'}}; {{'plus2_(x1,x2)'}}; {{'linear_(x)'}}; ...  
    {{'times2_(x1,x2)'}}; {{'sin_(x)'}}; {{'sin_(x)'}}];

idxToReplace = 5;

submdl.Mat = 0;
submdl.Tokens = [{{'x3'}}];
submdl.ParamNums = 0;
submdl.InitParams = {[]};
submdl.ArgDom = {[]};
submdl.ParDom = {[]};
submdl.Tex = [{{'x_3'}}];

estMdl = ReplaceSubModel(mdl, idxToReplace, submdl);

realMat = zeros(5,5);
realMat(1, 2) = 1;
realMat(2, 3) = 1;
realMat(3, 4) = 1;
realMat(2, 5) = 1;
realMdl.Mat = realMat;
realMdl.Tokens = [{{'root'}}; {{'times2_'}}; {{'sin_'}}; {{'x1'}}; {{'x3'}}];
realMdl.ParamNums = [0;0;0;0;0];
realMdl.InitParams = {[];[];[];[];[]};
realMdl.ParDom = {[]; [-Inf, Inf; -Inf, Inf]; []; []; []};
realMdl.ArgDom = {[-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; []; []; []};
realMdl.Tex = [{{'root(x)'}}; {{'times2_(x1,x2)'}}; {{'sin_(x)'}}; {{'x_1'}}; {{'x_3'}}];

assertEqual(estMdl.Mat, realMdl.Mat);
assertEqual(estMdl.Tokens, realMdl.Tokens);
assertEqual(estMdl.ParamNums, realMdl.ParamNums);
assertEqual(estMdl.InitParams, realMdl.InitParams);

end

function testRoot
mat = zeros(9, 9);
mat(1,7) = 1;
mat(7,9) = 1;
mat(7,5) = 1;
mat(5,6) = 1;
mat(5,8) = 1;
mat(6,4) = 1;
mat(8,3) = 1;
mat(9,2) = 1;
tokens = [{{'root'}}; {{'x1'}}; {{'x2'}}; {{'x1'}}; {{'plus2_'}}; {{'linear_'}}; ...  
    {{'times2_'}}; {{'sin_'}}; {{'sin_'}}];
mdl.Mat = mat;
mdl.Tokens = tokens;
mdl.ParamNums = [0;0;0;0;0;2;0;0;0];
mdl.InitParams = {[];[];[];[];[];[0 1];[];[];[];[]};
mdl.ParDom = {[-Inf, Inf]; []; []; []; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf]};
mdl.ArgDom = {[-Inf, Inf]; []; []; []; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf]};
mdl.Tex = [{{'root(x)'}}; {{'x_1'}}; {{'x_2'}}; {{'x_1'}}; {{'plus2_(x1,x2)'}}; {{'linear_(x)'}}; ...  
    {{'times2_(x1,x2)'}}; {{'sin_(x)'}}; {{'sin_(x)'}}];

idxToReplace = 1;

submdl.Mat = 0;
submdl.Tokens = [{{'x3'}}];
submdl.ParamNums = 0;
submdl.InitParams = {[]};
submdl.ArgDom = {[]};
submdl.ParDom = {[]};
submdl.Tex = [{{'x_3'}}];

estMdl = ReplaceSubModel(mdl, idxToReplace, submdl);

realMdl = submdl;

assertEqual(estMdl.Mat, realMdl.Mat);
assertEqual(estMdl.Tokens, realMdl.Tokens);
assertEqual(estMdl.ParamNums, realMdl.ParamNums);
assertEqual(estMdl.InitParams, realMdl.InitParams);

end
