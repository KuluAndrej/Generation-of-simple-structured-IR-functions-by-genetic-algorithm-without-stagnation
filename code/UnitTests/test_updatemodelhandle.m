function test_suite = test_updatemodelhandle( )
initTestSuite;
end

function testHandle
model.Mat = zeros(8, 8);
model.Mat(1,2) = 1;
model.Mat(1,7) = 1;
model.Mat(2,3) = 1;
model.Mat(2,5) = 1;
model.Mat(3,4) = 1;
model.Mat(5,6) = 1;
model.Mat(7,8) = 1;
model.Tokens = [{{'times2_'}}; {{'plus2_'}}; {{'linear_'}}; ...
    {{'x1'}}; {{'sin_'}}; {{'x2'}}; {{'sin_'}}; {{'x1'}}];
model.ParamNums = [2,2,1,0,1,0,1,0];
model.InitParams = {[0 1]; [1 0]; [0]; []; [2]; []; [3]; []};
model.ParDom = {[-Inf, Inf; -Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf Inf]; []; [-Inf Inf]; [];[-Inf Inf]; []};
model.ArgDom = {[-Inf, Inf; -Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf Inf]; []; [-Inf Inf]; [];[-Inf Inf]; []};
model.Tex = [{{'times2_(x1,x2)'}}; {{'plus2_(x1,x2)'}}; {{'linear_(x)'}}; ...
    {{'x_1'}}; {{'sin_(x)'}}; {{'x_2'}}; {{'sin_(x)'}}; {{'x_1'}}];
model.Handle = '@(w,x)times2_(w(1:2),plus2_(w(3:4),linear_(w(5:5),x(:,1)),sin_(w(6:6),x(:,2))),sin_(w(7:7),x(:,1)))';

newModel = UpdateModelHandle(model);

assertEqual(newModel.Handle, model.Handle);
end

function testArity4
model.Mat = zeros(5, 5);
model.Mat(1,2) = 1;
model.Mat(1,3) = 1;
model.Mat(1,4) = 1;
model.Mat(1,5) = 1;
model.Tokens = [{{'plus4_'}}; {{'x1'}}; {{'x2'}}; {{'x3'}}; {{'x4'}}];
model.ParamNums = [4,0,0,0,0];
model.InitParams = {[1 1 1 0]; []; []; []; []};
model.ParDom = {[-Inf, Inf; -Inf, Inf; -Inf, Inf; -Inf, Inf]; []; []; []; []};
model.ArgDom = {[-Inf, Inf; -Inf, Inf; -Inf, Inf; -Inf, Inf]; []; []; []; []};
model.Tex = [{{'root(x)'}}; {{'x_1'}}; {{'x_2'}}; {{'x_1'}}; {{'plus2_(x1,x2)'}}; {{'linear_(x)'}}; ...  
    {{'times2_(x1,x2)'}}; {{'sin_(x)'}}; {{'sin_(x)'}}];
model.Handle = '@(w,x)plus4_(w(1:4),x(:,1),x(:,2),x(:,3),x(:,4))';

newModel = UpdateModelHandle(model);
assertEqual(newModel.Handle, model.Handle);
end

function testNonDFSStructure
model.Mat = zeros(9, 9);
model.Mat(1,7) = 1;
model.Mat(7,9) = 1;
model.Mat(7,5) = 1;
model.Mat(5,6) = 1;
model.Mat(5,8) = 1;
model.Mat(6,4) = 1;
model.Mat(8,3) = 1;
model.Mat(9,2) = 1;
model.Tokens = [{{'root'}}; {{'x1'}}; {{'x2'}}; {{'x1'}}; {{'plus2_'}}; {{'linear_'}}; ...  
    {{'times2_'}}; {{'sin_'}}; {{'sin_'}}];
model.ParamNums = [1,0,0,0,2,1,2,1,1];
model.InitParams = {[1]; []; []; []; [0 1]; [0]; [1 0]; [2]; [3]};
model.ParDom = {[-Inf, Inf]; []; []; []; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf]};
model.ArgDom = {[-Inf, Inf]; []; []; []; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf; -Inf, Inf]; [-Inf, Inf]; [-Inf, Inf]};
model.Tex = [{{'root(x)'}}; {{'x_1'}}; {{'x_2'}}; {{'x_1'}}; {{'plus2_(x1,x2)'}}; {{'linear_(x)'}}; ...  
    {{'times2_(x1,x2)'}}; {{'sin_(x)'}}; {{'sin_(x)'}}];
model.Handle = '@(w,x)root(w(1:1),times2_(w(2:3),plus2_(w(4:5),linear_(w(6:6),x(:,1)),sin_(w(7:7),x(:,2))),sin_(w(8:8),x(:,1))))';

newModel = UpdateModelHandle(model);

assertEqual(newModel.Handle, model.Handle);
end

function testVariable
model.Mat = 0;
model.Tokens = [{{'x1'}}];
model.ParamNums = 0;
model.InitParams = {[]};
model.ParDom = {[]};
model.ArgDom = {[]};
model.Tex = [{{'x_1'}}];
model.Handle = '@(w,x)x(:,1)';

newModel = UpdateModelHandle(model);

assertEqual(newModel.Handle, model.Handle);
end
