%% Uncerrelated assets
r=0.05;
b=0;
K=1;
sigma1=0.18;
sigma2=0.25;
rho=0;
Sigma=[sigma1^2, rho*sigma1*sigma2; rho*sigma1*sigma2 sigma2^2];

L=1;
U=2;

bdCond={@(s1,s2, t) 0,...
    @(s1,s2,t) doubleOUT_call(s1, K, L, U, t, r, b, sigma1^2), ... 
    @(s1,s2,t) doubleOUT_call(s2, K, L, U, t, r, b, sigma2^2)};
T=1;
timeint=[0,T];

initV=@(s1,s2) max(s1+s2-K, 0);
geom=MakeGEOM('trapezoid.m');
