clc
clear
close all

N = 200;
K = 200; 
Sigma = 10; 
Mu = 2;
Xi = normrnd(Mu,Sigma,N,K);

disp(Xi)

% Среднее по ансамблю 
MU_xi_n = zeros(1,N);
for i=1:N 
    MU_xi_n(1,i) = mean(Xi(i, :));
end 

% Среднее по времени 
Xi_mean_k = zeros(1, K);
for k=1:K
    Xi_mean_k(1,k) = mean(Xi(:,k)); 
end 

figure("Name", "Среднее по ансамблю и по времени"); 
    plot(MU_xi_n);
    hold on;
    plot(Xi_mean_k); 
    hold on;
    legend("Среднее по ансамблю", "Среднее по времени"); 
    xlim([0 K]);

% 2e задание

figure('Name','Scatter plot')

nL = randi(K,3,2);
r(1,:) = xcorr(Xi(:,nL(1,1)),Xi(:,nL(1,2)),1,'normalized');
r(2,:) = xcorr(Xi(:,nL(2,1)),Xi(:,nL(2,2)),1,'normalized');
r(3,:) = xcorr(Xi(:,nL(3,1)),Xi(:,nL(3,2)),1,'normalized');
coeff = table(r(:,2)','VariableNames',{'r-coeff'});

a(1) = scatter(Xi(:,nL(1,1)),Xi(:,nL(1,2)),20,'r');
hold on
set(a(1),'Visible','off');
a(2) = scatter(Xi(:,nL(2,1)),Xi(:,nL(2,2)),20,'b');
hold on
set(a(2),'Visible','off');
a(3) = scatter(Xi(:,nL(3,1)),Xi(:,nL(3,2)),20,'g');
hold on
set(a(3),'Visible','off');
xlim([-20 50])
ylim([-20 50])
lgd = legend(num2str(nL(1,:)),num2str(nL(2,:)),num2str(nL(3,:)));
title('Scatter plot for random realisations')
title(lgd,'Order')

for k = 1:3
    cbx(k) = uicontrol('Style','checkbox', 'string', r(k,2) , 'Position',[20 70*k 70 15], 'Callback',{@checkBoxCallback,k,a});
end

disp(nL)
