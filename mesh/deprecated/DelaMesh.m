function T = DelaMesh(geom)
% DelaMesh builds a delaunayTriangulation T using the poly_geo object geom.
% If goem is 2D non-convex constrains are used. In 3D the triangulation
% will be performed on the convex hull of geom. 

if geom.dim==2
    T=delaunayTriangulation(geom.vertices, geom.edges);
elseif geom.dim==3
    T=delaunayTriangulation(geom.vertices);
else 
    error("Geometry need to be 2D or 3D \n")
end
end
