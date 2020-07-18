classdef poly_geo
    % poly_geo containg polygonal and polygonal-like geometries in form of
    % a list of vertices and a connectivity matrix between them. The
    % structure also work in 3D, but the description quickly becomes
    % cumbersome... 
    % poly_geo supports any 2D polygonal shape and CONVEX 3D polygonal-like
    % geometries.
    
    properties
        vertices    % Vertices of the polygonal geometry
        edges       % Edges of the poligonal geometry
        dim         % Dimension of the geometry
    end
    
    methods
        
        function geom=poly_geo(vertices, edges)
            geom.vertices=vertices;
            geom.edges=edges;
            [~,dim]=size(geom.vertices);
            geom.dim=dim;
        end
        
    end
end