%% Data for the double barrier basket option pricing
r=0.02;
b=0;
K=1;
sigma1=0.2;
sigma2=0.2;
rho=0;
Sigma=[sigma2^2, rho*sigma2*sigma2; rho*sigma1*sigma2 sigma2^2];

L=1;
U=2;

bdCond={@(s1,s2, t) 0,...
    @(s1,s2,t) doubleOUT_call(s1, K, L, U, t, r, b, sigma1^2), ... 
    @(s1,s2,t) doubleOUT_call(s2, K, L, U, t, r, b, sigma2^2)};
T=1;
timeint=[0,T];

initV=@(s1,s2) max(max(s1,s2)-K, 0);
geom=MakeGEOM('trapezoid.m');
