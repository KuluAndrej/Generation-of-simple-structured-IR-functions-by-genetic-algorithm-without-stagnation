function x = variablex(tw, lavg, l, c)
x = double(tw)*log10((double(lavg)+double(l))/double(l));
%{
if (x==0)
    [tw, log10(double(lavg+l)/l), double(lavg+l), double(lavg+l)/l]
end
%}