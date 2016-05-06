function test_suite = test_model2tex( )
initTestSuite;
end

function test1
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
model.Tex = {'times2_(x1,x2)'; 'plus2_(x1,x2)'; 'linear_(x)'; ...
    'x_1'; 'sin_(x)'; 'x_2'; 'sin_(x)'; 'x_1'};


esttex = Model2Tex(model, 1);
realtex = 'times2_(plus2_(linear_(x_1),sin_(x_2)),sin_(x_1))';

assertEqual(esttex, realtex);
end

function test2
model.Mat = zeros(9, 9);
model.Mat(1,2) = 1;
model.Mat(2,3) = 1;
model.Mat(2,8) = 1;
model.Mat(3,4) = 1;
model.Mat(3,6) = 1;
model.Mat(4,5) = 1;
model.Mat(6,7) = 1;
model.Mat(8,9) = 1;
model.Tokens = [{{'root'}}; {{'times2_'}}; {{'plus2_'}}; {{'linear_'}}; ...
    {{'x1'}}; {{'sin_'}}; {{'x2'}}; {{'sin_'}}; {{'x1'}}];
model.Tex = {'root(x)'; 'times2_(x1,x2)'; 'plus2_(x1,x2)'; 'linear_(x)'; ...
    'x_1'; 'sin_(x)'; 'x_2'; 'sin_(x)'; 'x_1'};

esttex = Model2Tex(model, 1);
realtex = 'root(times2_(plus2_(linear_(x_1),sin_(x_2)),sin_(x_1)))';

assertEqual(esttex, realtex);
end

function test_simple
model.Mat = 0;
model.Tokens = [{{'x1'}}];
model.Tex = {'x_1'};

esttex = Model2Tex(model, 1);
realtex = 'x_1';

assertEqual(esttex, realtex);
end


