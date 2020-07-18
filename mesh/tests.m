close all; clear; clc
%% Define polygonal geometry
run('geometries/trapezoid.m')
% run('geometries/Lshape.m')
% run('geometries/sqhole_square.m')

% run('geometries/cube.m')
% run('geometries/trapezoid_3D.m')

geom=poly_geo(vertices, edges);
d=geom.dim;

%% Plot domain
figure;
geom.show('LineWidth',1.5,'EdgeColor','r')
hold on; axis image off;

%% Lets try a triangulation 
T=DelaMesh(geom);
show_mesh(T,'FaceColor','w','FaceAlpha',0.5)

%% Computation of edges and faces 
E=mesh_edges(T)
F=mesh_faces(T)

%% Coundary edges and faces 
bdE=boundary_edges(T)

%% Subdivision of triangles
% edges_indices=T.edges;
% midpts=0.5*(T.Points(edges_indices(:,1),:)+T.Points(edges_indices(:,2),:));
% T=delaunayTriangulation([T.Points; midpts]);

T=splitrefineDM(T);

figure;
geom.show('LineWidth',1.5,'EdgeColor','r')
hold on; axis image off;
show_mesh(T,'FaceColor','w','FaceAlpha',0.5)

Q_max=max(RadEdRat(T))