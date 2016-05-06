function test_suite = test_extraxtsubmodel( )
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


idxToExtract = 5;

estMdl = ExtractSubModel(mdl, idxToExtract);

realMat = zeros(5, 5);
realMat(1, 2) = 1;
realMat(1, 4) = 1;
realMat(2, 3) = 1;
realMat(4, 5) = 1;
realTokens = [{{'plus2_'}}; {{'linear_'}}; {{'x1'}}; {{'sin_'}}; {{'x2'}}];
realMdl.Mat = realMat;
realMdl.Tokens = realTokens;
realMdl.ParamNums = [0;2;0;0;0];
realMdl.InitParams = {[];[0 1];[];[];[]};

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
mdl.InitParams = {[];[];[];[];[];[0 1];[];[];[]};
mdl.ParDom = {[-Inf, Inf]; []; []; []; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf]};
mdl.ArgDom = {[-Inf, Inf]; []; []; []; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf]};
mdl.Tex = [{{'root(x)'}}; {{'x_1'}}; {{'x_2'}}; {{'x_1'}}; {{'plus2_(x1,x2)'}}; {{'linear_(x)'}}; ...  
    {{'times2_(x1,x2)'}}; {{'sin_(x)'}}; {{'sin_(x)'}}];


idxToExtract = 1;

estMdl = ExtractSubModel(mdl, idxToExtract);

realMat = zeros(9, 9);
realMat(1,2) = 1;
realMat(2,3) = 1;
realMat(2,8) = 1;
realMat(3,4) = 1;
realMat(3,6) = 1;
realMat(4,5) = 1;
realMat(6,7) = 1;
realMat(8,9) = 1;

realTokens = [{{'root'}}; {{'times2_'}}; {{'plus2_'}}; {{'linear_'}}; ...
    {{'x1'}}; {{'sin_'}}; {{'x2'}}; {{'sin_'}}; {{'x1'}}];
realMdl.Mat = realMat;
realMdl.Tokens = realTokens;
realMdl.ParamNums = [0;0;0;2;0;0;0;0;0];
realMdl.InitParams = {[];[];[];[0 1];[];[];[];[];[];};

assertEqual(estMdl.Mat, realMdl.Mat);
assertEqual(estMdl.Tokens, realMdl.Tokens);
assertEqual(estMdl.ParamNums, realMdl.ParamNums);
assertEqual(estMdl.InitParams, realMdl.InitParams);

end

function testVariable
mat = zeros(9, 9);
mat(1,2) = 1;
mat(2,3) = 1;
mat(2,8) = 1;
mat(3,4) = 1;
mat(3,6) = 1;
mat(4,5) = 1;
mat(6,7) = 1;
mat(8,9) = 1;
tokens = [{{'root'}}; {{'times2_'}}; {{'plus2_'}}; {{'linear_'}}; ...
    {{'x1'}}; {{'sin_'}}; {{'x2'}}; {{'sin_'}}; {{'x1'}}];

mdl.Mat = mat;
mdl.Tokens = tokens;
mdl.ParamNums = [0;0;0;0;0;2;0;0;0];
mdl.InitParams = {[];[];[];[];[];[0 1];[];[];[]};
mdl.ParDom = {[-Inf, Inf]; []; []; []; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf]};
mdl.ArgDom = {[-Inf, Inf]; []; []; []; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf]};
mdl.Tex = [{{'root(x)'}}; {{'times2_(x1,x2)'}}; {{'plus2_(x1,x2)'}}; {{'linear_(x)'}}; ...
    {{'x_1'}}; {{'sin_(x)'}}; {{'x_2'}}; {{'sin_(x)'}}; {{'x_1'}}];

idxToExtract = 5;

estMdl = ExtractSubModel(mdl, idxToExtract);

realMat = 0;
realTokens = [{{'x1'}}];

realMdl.Mat = realMat;
realMdl.Tokens = realTokens;
realMdl.ParamNums = 0;
realMdl.InitParams = {[]};

assertEqual(estMdl.Mat, realMdl.Mat);
assertEqual(estMdl.Tokens, realMdl.Tokens);
assertEqual(estMdl.ParamNums, realMdl.ParamNums);
assertEqual(estMdl.InitParams, realMdl.InitParams);


end