close all; 
clear; clc
addpath(genpath('./'))

%% Define problem data
problem=makePROB('problem1.m');

% Plot domain
figure;
problem.geometry.show('LineWidth',1.5,'EdgeColor','r')
title("Geometry of the domain")

%% Lets try a triangulation
msh=tri_mesh(problem.geometry);
msh.show;
msh.show_labels;

%% Subdivision of triangles
for idx=1:2
msh=msh.midsplitref;
end
    
close
figure;
problem.geometry.show('LineWidth',1.5,'EdgeColor','r')
hold on; axis image off;
msh.show
% msh.show_labels

%% Assemble mass matrix

M = Mass(msh);

figure
spy(M)
title("Mass matrix")

%% Assemble stiffness matrix

A = Stiff(problem,msh);

figure
spy(A)
title("Stiffness matrix")

%% Compute Dirichlet nodes and their identifiers
[DIR, DIRid, IND] = GRPnodes(msh);

%% Remove rows of boundary test functions
A=rmRows(A,DIR);
M=rmRows(M,DIR);

%% Time discretization by theta-method

% Discretization parameters
Nt=100;
Dt=(problem.time(2)-problem.time(1))/Nt;
theta=0;

% Matrices for theta-method
L = -M + theta*Dt*A;
LIND = rmCols(L,DIR);
R = M + (1-theta)*Dt*A;

%% Compute initial datum and try to plot it
w0=INITeval(problem.initV, msh);
w0(DIR(DIRid==1))=0; %%%%%% CHECK!!! Maybe linking initial condition and BC helps

%% Test INTERPlinear
% [X,Y]=meshgrid(sort(msh.nodes(:,1)),sort(msh.nodes(:,2)));
% 
% for xdx=1:size(X,2)
%     for ydx=1:size(Y,1)
%         W(xdx,ydx) = INTERPlinear(msh, w0, X(xdx,ydx), Y(xdx,ydx));
%     end
% end
%     
% surf(X,Y,W)

%% Plot initial condition 
figure
TO=triangulation(msh.elems, msh.nodes(:,1), msh.nodes(:,2), w0);
trisurf(TO, 'FaceColor', 'w')
axis equal
title("Initial condition")

%% Advance solution in time by theta-method
warning("Figures will be closed!")
pause
close all; clc

for idx=1:Nt
    w1DIR = DIReval(problem.bdcond, DIR, DIRid, msh, Dt*idx);
    F = -R*w0;
    B = -L*w1DIR;
    w1IND = LIND \ (F+B);
    w1 = mergeDIRINDvals(w1DIR, w1IND, IND);
    w0=w1;
    
    TO=triangulation(msh.elems, msh.nodes(:,1), msh.nodes(:,2), w0);
    
    trisurf(TO, 'EdgeAlpha',0.3)
    axis equal
    title(strcat("Solution (doubt it!) at time ", string(Dt*idx)))
    pause(0.1)
end

