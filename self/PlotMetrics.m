function [] = PlotMetrics()
    %{
    A = dlmread('hardThresh.txt');
    A = A(:,1:ceil(length(A(1,:))/1.8));
    B = dlmread('incrProportReduc.txt');
    B = B(:,1:ceil(length(B(1,:))/1.8));
    C = dlmread('leavesNumb.txt');
    C = C(:,1:ceil(length(C(1,:))/1.8));
    norm(C(2,:)-C(3,:))/norm(C(2,:))
    
    figure
    ids = 10*(1:length(A(1,:)));
    subplot(3,3, 1);
    plot(ids,A(1,:),'LineWidth',2);  
    %title('R_1. ','FontSize',13,'FontSize',13,'FontWeight','bold')
    title('R_1. ','FontSize',15,'FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_1','FontSize',13,'FontWeight','bold') % y-axis label
    
    subplot(3,3, 4);
    plot(ids,A(2,:),'LineWidth',2);  
    set(get(gca,'YLabel'),'Rotation',0)
    %title('2nd metric','FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_2','FontSize',13,'FontWeight','bold') % y-axis label
    
    subplot(3,3, 7);
    plot(ids,A(3,:),'LineWidth',2);  
    set(get(gca,'YLabel'),'Rotation',0)
    %title('3rd metric','FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_3','FontSize',13,'FontWeight','bold') % y-axis label
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    subplot(3,3, 2);
    plot(ids,B(1,:),'LineWidth',2);  
    title('R_2','FontSize',15,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_1','FontSize',13,'FontWeight','bold') % y-axis label
    
    subplot(3,3, 5);
    plot(ids,B(2,:),'LineWidth',2);  
    %title('2nd metric','FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_2','FontSize',13,'FontWeight','bold') % y-axis label
    
    subplot(3,3, 8);
    plot(ids,B(3,:),'LineWidth',2);  
    %title('3rd metric','FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_3','FontSize',13,'FontWeight','bold') % y-axis label
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    subplot(3,3, 3);
    plot(ids,C(1,:),'LineWidth',2);  
    title('R_3','FontSize',15,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_1','FontSize',13,'FontWeight','bold') % y-axis label
    
    subplot(3,3, 6);
    plot(ids,C(2,:),'LineWidth',2);  
    %title('2nd metric','FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_2','FontSize',13,'FontWeight','bold') % y-axis label
    
    subplot(3,3, 9);
    plot(ids,C(3,:),'LineWidth',2);  
    %title('3rd metric','FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_3','FontSize',13,'FontWeight','bold') % y-axis label    
    %}
    %A = dlmread('hardThresh.txt');
    %A = dlmread('withoutRegTruth.txt');
    B = dlmread('incrProportReduc.txt');
    
    C = dlmread('leavesNumb.txt');
    C = B;
    norm(C(2,:)-C(3,:))/norm(C(2,:))
    
    figure
    ids = 10*(1:length(A(1,:)));
    subplot(4,1, 1);
    plot(ids,A(1,:),'LineWidth',2);  
    %title('R_1. ','FontSize',13,'FontSize',13,'FontWeight','bold')
    title('R_1. ','FontSize',15,'FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_1','FontSize',13,'FontWeight','bold') % y-axis label
    
    subplot(4,1, 2);
    plot(ids,A(2,:),'LineWidth',2);  
    set(get(gca,'YLabel'),'Rotation',0)
    %title('2nd metric','FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_2','FontSize',13,'FontWeight','bold') % y-axis label
    
    subplot(4,1, 3);
    plot(ids,A(3,:),'LineWidth',2);  
    set(get(gca,'YLabel'),'Rotation',0)
    %title('3rd metric','FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('\mu_3','FontSize',13,'FontWeight','bold') % y-axis label
    
    subplot(4,1, 4);
    plot(ids,A(4,:),'LineWidth',2);  
    set(get(gca,'YLabel'),'Rotation',0)
    %title('3rd metric','FontSize',13,'FontWeight','bold')
    set(get(gca,'YLabel'),'Rotation',0)
    xlabel('Number of iteration','FontSize',13,'FontWeight','bold') % x-axis label
    ylabel('len','FontSize',13,'FontWeight','bold') % y-axis label
end