function  y = normalpdf_(w,x)
y=1/(w(1)*sqrt(2*pi))*exp(-1*((x-w(2)).^2)/(2*w(1)^2));


