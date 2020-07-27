close all; clear
addpath(genpath('./'))

%% Define polygonal geometry
run('mesh/geometries/trapezoid.m')
% run('mesh/geometries/Lshape.m')
% run('mesh/geometries/sqhole_square.m')

% run('mesh/geometries/cube.m')
% run('mesh/geometries/trapezoid_3D.m')

geom=poly_geo(vertices, edges, bdid);
d=geom.dim;

%% Plot domain
figure;
geom.show('LineWidth',1.5,'EdgeColor','r')

%% Define problem data
r=0.01;
sigma=0.5;
rho=1;
Sigma=sigma^2*eye(2);
problem=problem_data(r,Sigma, geom, [], []);

%% Lets try a triangulation 
msh=tri_mesh(geom);
msh.show;
msh.show_labels;

msh.radedrat

%% Subdivision of triangles
msh=msh.midsplitref;

figure;
geom.show('LineWidth',1.5,'EdgeColor','r')
hold on; axis image off;
msh.show
msh.show_labels


msh.radedrat

%% Assemble mass matrix
figure
M = Mass(msh);
spy(M)
title("Mass matrix")

%% Assemble stiffness matrix
% A_K=Stiff_loc(problem,3,msh)
figure
A = Stiff(problem,msh);
spy(A)
title("Stiffness matrix")

%% Remove rows of boundary test functions

