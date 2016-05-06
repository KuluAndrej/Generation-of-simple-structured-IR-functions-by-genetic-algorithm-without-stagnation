function y = variabley(nw,n)
%{
k = min(50*double(nw), double(n));
y = 100*k/double(n);
y = 100-y;
%}
y = double(nw)/double(n);

%{
if(y==0) 
    [double(nw), n]
end
%}