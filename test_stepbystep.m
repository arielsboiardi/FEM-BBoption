close all; 
clear; clc
addpath(genpath('./'))

%% Define problem data
problem=makePROB('problem_test.m');

% Plot domain
figure;
problem.geometry.show('LineWidth',1.5,'EdgeColor','r')
title("Geometry of the domain")

%% Lets try a triangulation
msh=tri_mesh(problem.geometry);
msh.show;
msh.show_labels;

%% Subdivision of triangles
for idx=1:4
    if idx>=6
        warning("Not enough memory for this grid")
        break
    end
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
theta=0.5;

% Matrices for theta-method
L = M/Dt + (1-theta)*A;
R = M/Dt - theta*A;

LIND = rmCols(L,DIR);
PIND=pinv(LIND);

%% Compute initial datum and try to plot it
w0=INITeval(problem.initV, msh);
w0(DIR(DIRid==1))=0;


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
title("Final condition")

%% Advance solution in time by theta-method
warning("Figures will be closed!")
cont_flag=input("Do you want to solve the problem? [Y/n] \n",'s');
if cont_flag=='n'
    return
end

close all; clc

for idx=1:0.75*Nt
    w1DIR = DIReval(problem.bdcond, DIR, DIRid, msh, Dt*(idx));
    F = R*w0;
    B = L*w1DIR;
    w1IND = PIND * (F - B);
    w1 = mergeDIRINDvals(w1DIR, w1IND, IND);
    w0=w1;
    
    TO=triangulation(msh.elems, msh.nodes(:,1), msh.nodes(:,2), w0);

    trisurf(TO, 'EdgeAlpha',0.3)
    axis equal
    pause(0.1)
end