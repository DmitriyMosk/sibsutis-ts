clear; 

% Коэффициенты в матрице переходных вероятностей
P = [1, 1, 1, 1; 1, 1, 1, 1; 1, 1, 1, 1; 1 0 0 1];

% №2
MC = dtmc(P, "StateNames" , ["Healthy" "Unwell" "Sick" "Very sick"]);

% №3
MCP = MC.P
S=sum(MCP,2)

% №4
figure('Name','Граф цепи маркова','NumberTitle','off')
graphplot(MC,'ColorEdges',true);

% №5
P_cum = MCP;
for K = 1:4
    for L=1:3
        P_cum(K,L+1) = P_cum(K,L) + P_cum(K,L+1);
    end
end
P_cum

clear K L


N=[200, 1000, 10000];

figure('Name','Моделирование поведения цепи Маркова','NumberTitle','off')
% №6
    text=['Всего ',num2str(N(1)),' положений'];
    title(text)
    hold on
    z = st(N(1),P_cum);
    hold off

figure('Name','Моделирование поведения цепи Маркова 8','NumberTitle','off')
% №7/8
subplot(2,1,1)
    text=['Всего ',num2str(N(2)),' положений'];
    title(text)
hold on
    z = st(N(2),P_cum);
hold off
subplot(2,1,2)
    text=['Всего ',num2str(N(3)),' положений'];
    title(text)
hold on
    z = st(N(3),P_cum);
hold off

% № 9\11

P_obs=zeros(4,4,3);
for k=1:3
    for n=2:N(k)
        for i=1:4
            if z(n-1,1)==i
                for j=1:4
                    if z(n,1)==j
                        P_obs(i,j,k)=P_obs(i,j,k)+1;
                    end
                end
            end
        end
    end
end

figure(4)
    MC_Obs1=dtmc(normalize(P_obs(:,:,1),'norm',1),'StateNames',["Healthy" "Unwell" "Sick" "Very sick"]);
    graphplot(MC_Obs1,'ColorEdges',true);
    MC_Obs1T = MC_Obs1.P
figure(5)
    MC_Obs2=dtmc(normalize(P_obs(:,:,2),'norm',1),'StateNames',["Healthy" "Unwell" "Sick" "Very sick"]);
    graphplot(MC_Obs2,'ColorEdges',true);
    MC_Obs2T = MC_Obs2.P
figure(6)
    MC_Obs3=dtmc(normalize(P_obs(:,:,3),'norm',1),'StateNames',["Healthy" "Unwell" "Sick" "Very sick"]);
    graphplot(MC_Obs3,'ColorEdges',true);
    MC_Obs3T = MC_Obs3.P

% №12
lam=35;
mu=50;
n=7;
m=5;

p=lam/mu;
Psum=0;
for i=0:m
    Psum=Psum+(p^i)/(factorial(i));
end
p0=Psum^(-1)
Potk=(p^(n+m))*p0/((n^m)*factorial(n))
Q=1-Potk
A=lam*Q

kzan=A/mu
Loch=(p^(n+1))*(1-((p/n)^m)*(m+1-m*p/n))*p0/(n*factorial(n)*(1-p/n)^2)
Toch=Loch/lam
Lsist=Loch+kzan
Tsist=Lsist/lam