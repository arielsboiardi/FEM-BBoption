%% Data for the double barrier basket option pricing
r=0.2;
b=0;
K=1;
sigma=0.25;
rho=0.7;
Sigma=[sigma^2, rho*sigma^2; rho*sigma^2 sigma^2];

L=1;
U=2;

bdCond={@(s1,s2, t) 0,...
    @(s1,s2,t) doubleOUT_call(s1, K, L, U, t, r, b, sigma^2), ... 
    @(s1,s2,t) doubleOUT_call(s2, K, L, U, t, r, b, sigma^2)};
T=1;
timeint=[0,T];

initV=@(s1,s2) max(s1+s2-K, 0);
geom=MakeGEOM('trapezoid.m');
