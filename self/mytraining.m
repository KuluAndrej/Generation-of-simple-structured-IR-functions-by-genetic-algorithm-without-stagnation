%{
const = 40;
x = 1:const;
x = x*pi/const;
y = x+0.05*ones(1,const);
[X,Y] = meshgrid(x,y);
x = [X(:),Y(:)];
y1 = arrayfun(@(a) sin(x(a,1))*sin(x(a,2)), 1:const*const)';
y2 = arrayfun(@(a) 0.08*x(a,1),  1:const*const)';
y3 = arrayfun(@(a) x(a,2)*sin(x(a,1)), 1:const^2)';
[y1, y2, y3]
y = arrayfun(@(a) 1.2*sin(x(a,1))*sin(x(a,2))+0.08*x(a,1)+x(a,2)*sin(x(a,1)), 1:const^2)'+normrnd(0,0.1,[1 const^2])';
[y,x];
dlmwrite('data/demo.dat-syn.txt',[y,x]);
%}
%{
function [] = mytraining()
STEP = 10;
c = [-100:STEP:100]/100;

a = dlmread('templ7.txt');
a2 = dlmread('templ7.txt');
b1 = a(:,1);
b2 = a(:,2);
b3 = a(:,3);
b12 = a2(:,1);
b22 = a2(:,2);
b32 = a2(:,3);


n = length(b1);
n2 = length(b12);
length(find(b3>0))/n
length(find(b3<0))/n
d1 = densityFunc(b1,c)/n;
d2 = densityFunc(b2,c)/n;
d3 = densityFunc(b3,c)/n;
d12 = densityFunc(b12,c)/n;
d22 = densityFunc(b22,c)/n;
d32 = densityFunc(b32,c)/n;
c = c(1:length(c)-1);
c = c + ones(1,length(c))*STEP/400;
figure
set(0,'DefaultAxesFontName','TimesNewRoman');
title('рис');
    subplot(3,2,1);
    bar(c,d1);
    %plot(c,d1,'-r','LineWidth',2);
    
    title('SYNTHETIC DATA');
    hold on
    ylabel('MSE');
    xlabel('% of models with changing |S| > x%');
    axis([-1,1,0,1]);
    hold off;


    subplot(3,2,3);
    %plot(c,d2,'-r','LineWidth',2);
    bar(c,d2);
    hold on
    ylabel('Error');
    xlabel('% of models with changing F > x%');
    axis([-1,1,0,1]);
    hold off;

    subplot(3,2,5);
    %plot(c,d3,'-r','LineWidth',2);
    bar(c,d3);
    hold on
    
    ylabel('MSE on the control');
    xlabel('% of models with changing S_c > x%');
    axis([-1,1,0,1]);
    hold off;

    subplot(3,2,2);
    %plot(c,d12,'-r','LineWidth',2);
    bar(c,d12);
    title('OPTIONS');
    hold on
    xlabel('% of models with changing |S| > x%');
    axis([-1,1,0,1]);
    hold off;


    subplot(3,2,4);
    %plot(c,d22,'-r','LineWidth',2);
    bar(c,d22);
    hold on
    xlabel('% of models with changing F > x%');
    axis([-1,1,0,1]);
    hold off;

    subplot(3,2,6);
    %plot(c,d32,'-r','LineWidth',2);
    bar(c,d32);
    hold on
    
    xlabel('% of models with changing S_c > x%');
    axis([-1,1,0,1]);
    hold off;
end
function [array] = densityFunc(vector1,vector2)
    array = ones(length(vector2)-1,1);
    for ii=1:(length(vector2)-1)
        array(ii) = length(find(vector1>vector2(ii) & vector1<vector2(ii+1)));
    end
    return
end
%}
%{
function [] = mytraining()
tic
handle = 'parabola_(w(1:3),plus2_([],linear_(w(4:5),parabola_(w(6:8),times2_([],x(:,1),sin_([],x(:,2))))),x(:,2)))';
inputfile = fopen('templ8.txt');
matValues = textscan(inputfile, '%s%s', 'delimiter', ' ');
fclose('all');
NUMBFILES = length(matValues{1});
for ii = 1:NUMBFILES
    entTok = regexp(handle,matValues{1}{ii},'once');
    if ~isempty(entTok)
        endTok = balancedBr(handle,entTok);
        handle = [handle(1:entTok-1), regexprep(handle(entTok:endTok),matValues{1}{ii},matValues{2}{ii}), handle(endTok+1:length(handle))];
    end
end
handle
toc
end
function [indexStr] = balancedBr (handle, first)
    
%function gets such smallest index i that sequence from the first to i have
%all the brackets balanced 
    if strcmp(handle(first),'x')
        indexStr = first+5;
        return
    end
    summ = 0;
    b = true;
    %{
    if (strcmp(handle(first),'x'))
        b = false;
        first=first+2;
    end
    %}    
    while (summ>0)||b
        if (strcmp(handle(first),'('))
        summ = summ + 1;
        b = false;
        end
        if (strcmp(handle(first),')'))
        summ = summ - 1;
        end
        
        
        first = first + 1;
    end
    indexStr = first - 1;
end
%}
v = ['str'; 'rew'; 'ter'];
num = length(v);
metrMat = zeros(num);
for ii = 1:num
    for jj = 1:num
        metrMat(ii,jj) = func(v(ii),v(jj));
    end
end
metrMat
