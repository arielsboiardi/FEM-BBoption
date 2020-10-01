%% Computations for comparison table 2
close all;
clear; clc
addpath(genpath('./'))

%% Test solver_FEMBBoption

%Problem data
problem=makePROB('problem0.m');

% Mesh generation
msh=tri_mesh(problem.geometry);

% Mesh refinement
for idx=1:5
    if idx>=6
        warning("Not enough memory for this grid :(")
        fprintf("I will do 5 refinements instead... \n")
        break
    end
    msh=msh.midsplitref;
end

%% Theta-method sovler
Nt=500;

% BEU
theta=0;
opt=solver_options(Nt,theta);

tic 
w=solver_FEMBBoption(problem, msh, opt);
CPUtime_BEU=toc

Vh_BEU=INTERPlinear(msh, w, 1.25, 0.25)

% CN
theta=0.5;
opt=solver_options(Nt,theta);

tic 
w=solver_FEMBBoption(problem, msh, opt);
CPUtime_CN=toc

Vh_CN=INTERPlinear(msh, w, 1.25, 0.25)