close all; clear; clc
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

%% Subdivision of triangles
% edges_indices=T.edges;
% midpts=0.5*(T.Points(edges_indices(:,1),:)+T.Points(edges_indices(:,2),:));
% T=delaunayTriangulation([T.Points; midpts]);

T=splitrefineDM(T);

figure;
geom.show('LineWidth',1.5,'EdgeColor','r')
hold on; axis image off;
show_mesh(T,'FaceColor','w','FaceAlpha',0.5)


%% Build tri_mesh object from the delaunayTriangulation T
msh=tri_mesh(T);
figure
geom.show('LineWidth',1.5,'EdgeColor','r')
msh.show('FaceAlpha',0.5);
msh.show_labels

%% Build mass matrix
figure
M = Mass(msh);
spy(M)
title("Mass matrix")

%% Build stiffness matrix
% A_K=Stiff_loc(problem,3,msh)
figure
A = Stiff(problem,msh);
spy(A)
title("Stiffness matrix")