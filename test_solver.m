close all;
clear; clc
addpath(genpath('./'))

%% Test solver_FEMBBoption

%Problem data
problem=makePROB('problem41.m');

% Mesh generation
msh=tri_mesh(problem.geometry);

% Mesh refinement
for idx=1:4
    if idx>=6
        warning("Not enough memory for this grid :(")
        fprintf("I will do 5 refinements instead... \n")
        break
    end
    msh=msh.midsplitref;
end

%% Theta-method sovler
Nt=100;
theta=0.5;

opt=solver_options(Nt,theta);

w=solver_FEMBBoption(problem, msh, opt);

%% Compare with the "known value"
TO=triangulation(msh.elems, msh.nodes(:,1), msh.nodes(:,2), w);
trisurf(TO, 'EdgeAlpha',0.3)
axis equal
view([45, 25])

%% Plot
% TO=triangulation(msh.elems, msh.nodes(:,1), msh.nodes(:,2), w);
% 
% trisurf(TO, 'EdgeAlpha',0.3)
print('xport_figure','-dsvg', '-painters')