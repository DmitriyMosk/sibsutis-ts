N = 200;
K = 200; 
Sigma = 1; 
Mu = 0;

w = zeros(N,K);

for i=2:K 
    for k=1:N
        w(1,k) = 0;
        w(i,k) = w(i-1,k)+normrnd(Mu, Sigma);
    end
end

figure('Name','винеровский процесс');
    plot(w);
    title('Все реализации винеровского процесса');

figure('Name','Sctarret diogram','NumberTitle','off');
subplot(2,1,1);

X = [10, 50, 100, 200];
Y = [9, 49, 99, 199];
for i = 1:4
    x =w(X(i),:);
    y =w(Y(i),:);
    c = linspace(1,10,length(x));
    scatter(x,y,[],c);
    title('Scatter (10,9) (50,49) (100,99) (200,199)');
    xlabel('X');
    ylabel('Y');
    ylim([-50 60]);
    xlim([-40 50]);
    hold on;
end
subplot(2,1,2);

X = [50, 100, 200];
Y = [40, 90, 190];
for i = 1:3
    x =w(X(i),:);
    y =w(Y(i),:);
    c = linspace(1,10,length(x));
    scatter(x,y,[],c);
    title('Scatter (50,40) (100,90) (200,190)');
    xlabel('X');
    ylabel('Y');
    ylim([-50 60]);
    xlim([-40 50]);
    hold on;
end

clear X Y x y i c

ACF = zeros(1,N);

for i = 1:N
    w1 = circshift(w,1);
    W = w.*w1;
    ACF(1,i) = mean(W(i,:));
end
figure()
plot(ACF);
hold on
plot([0 N],[0 max(ACF)]);
xlim([0 N])
ylim([0 max(ACF)])
title('Autocorr function')
xlabel('X')
ylabel('Y')