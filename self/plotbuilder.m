function [] = plotbuilder()
    inputfile = fopen('plot.txt');
    a = textscan(inputfile, '%f%f%f', 'delimiter', ' ');
    step = 1;
    ind = find(abs(a{2})<step-0.1);
    n = length(ind);
    [a{1},a{2},a{3}]
    MSE = a{1}(ind)';
    Error = a{2}(ind)';
    Contr = a{3}(ind)';
    %mean(a{2})
    figure
    subplot(3,1,1);
    plot(1:n,MSE,'+','MarkerSize',5,'MarkerEdgeColor','r');
    hold on
    %plot(1:n,100*MSE2,'o','MarkerSize',5);
    plot(0:n,ones(1,n+1)-1);
    %legend('for initial', 'for simplified');
    ylabel('MSE');
    xlabel('Simplified model number');
    axis([0,n+1,-step,step]);
    hold off;


    subplot(3,1,2);
    plot(1:n,Error,'+','MarkerSize',5,'MarkerEdgeColor','r');
    hold on
    %plot(1:n,100*Error2,'o','MarkerSize',5);
    plot(0:n,ones(1,n+1)-1);
    %legend('for initial', 'for simplified');
    ylabel('Error');
    xlabel('Simplified model number');
    axis([0,n+1,-(0.5*step),0.5*step]);
    hold off;

    subplot(3,1,3);
    plot(1:n,Contr,'+','MarkerSize',5,'MarkerEdgeColor','r');
    hold on
    %plot(1:n,100*Contr2,'o','MarkerSize',5);
    plot(0:n,ones(1,n+1)-1);
    %legend('for initial', 'for simplified');
    ylabel('MSE on the control');
    xlabel('Simplified model number');
    axis([0,n+1,-(0.5*step),0.5*step]);
    hold off;

end