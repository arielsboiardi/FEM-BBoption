clear all; close all; clc

%% Test double out against literature data 
S=1:0.001:2;
K=1.5;
r=0.01;
b=0;

L=1;
U=2;

T=0.1;
sigma2=(0.05)^2;

c=doubleOUT_call(S,K,L,U,T,r,b,sigma2);

%% Try to plot the values
plot(S,c)