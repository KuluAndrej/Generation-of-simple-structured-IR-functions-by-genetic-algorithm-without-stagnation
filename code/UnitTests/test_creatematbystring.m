function test_suite = test_creatematbystring()
initTestSuite;
end

function testArity2
modelStr = 'times2_(plus2_(linear_(x1),sin_(x2)),sin_(x1))';
[createdMat, createdTokens] = CreateMatByString(modelStr);
trueMat = zeros(8, 8);
trueMat(1,2) = 1;
trueMat(1,7) = 1;
trueMat(2,3) = 1;
trueMat(2,5) = 1;
trueMat(3,4) = 1;
trueMat(5,6) = 1;
trueMat(7,8) = 1;
trueTokens = [{{'times2_'}}; {{'plus2_'}}; {{'linear_'}}; ...
    {{'x1'}}; {{'sin_'}}; {{'x2'}}; {{'sin_'}}; {{'x1'}}];

assertEqual(createdMat, trueMat);
assertEqual(createdTokens, trueTokens);
end

function testArity3
modelStr = 'times2_(x1,plus3_(x3,sin_(x3),times2_(cos_(x4),x5)))';
trueTokens = [{{'times2_'}}; {{'x1'}}; {{'plus3_'}}; {{'x3'}}; ...
    {{'sin_'}}; {{'x3'}}; {{'times2_'}}; {{'cos_'}}; {{'x4'}}; {{'x5'}}];

[createdMat, createdTokens] = CreateMatByString(modelStr);
trueMat = zeros(10, 10);
trueMat(1,2) = 1;
trueMat(1,3) = 1;
trueMat(3,4) = 1;
trueMat(3,5) = 1;
trueMat(3,7) = 1;
trueMat(5,6) = 1;
trueMat(7,8) = 1;
trueMat(7,10) = 1;
trueMat(8,9) = 1;
assertEqual(createdMat, trueMat);
assertEqual(createdTokens, trueTokens);
end

function testSpaces
modelStr = 'times2_ ( plus2_ ( linear_( x1), sin_(  x2  )), sin_(x1    ))';
[createdMat, createdTokens] = CreateMatByString(modelStr);
trueMat = zeros(8, 8);
trueMat(1,2) = 1;
trueMat(1,7) = 1;
trueMat(2,3) = 1;
trueMat(2,5) = 1;
trueMat(3,4) = 1;
trueMat(5,6) = 1;
trueMat(7,8) = 1;
trueTokens = [{{'times2_'}}; {{'plus2_'}}; {{'linear_'}}; ...
    {{'x1'}}; {{'sin_'}}; {{'x2'}}; {{'sin_'}}; {{'x1'}}];

assertEqual(createdMat, trueMat);
assertEqual(createdTokens, trueTokens);
end
