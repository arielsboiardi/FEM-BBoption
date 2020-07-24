classdef tri_mesh
    % tri_mesh class for unstructured triangular mesh os polygonal
    % geometry. The triangulation is based on the Delaunay triangulation
    % algorithm implemented in the Qhull library, and can therefore only
    % triangulate convex geometries. In the case of a non convex geoetry
    % the the trinagulation covers the convex hull. 
    % 
    % PROPERTIES:
    % Name
    % nodes     Nodes or vertices of the trinauglation. Every row contains
    %           the compoent of the node with the correpsonding index.
    % elems     Connection matrix of the trinagulation. Every row
    %           identifies one simplex by its vertices.
    % PhysBD    List of edges that are on the boundary and their respective
    %           boundary indetifiers. Every row the first two components
    %           are indices of the endpoints of the edge, the last
    %           component is the boundry identifier relative to the edge.
    % dim       Dimension of the space, currently unsed, but whatever...
    
    
    properties
        nodes       % Vertices of the triangulation
        elems       % Descritpion of elements trhough connectivity matrix
        PhysBD      % Physical boundaries of the domain
        dim         % Geometric dimension of the embeddign space
    end
    
    methods
        
        function msh=tri_mesh(varargin)
            % Constructor of tri_mesh objects.
            % 
            % Inputs:
            %   poly_geo object of the domain to triangulate
            % OR
            %   nodes, elems, PhysBD data as described in properties
            %
            
            if nargin==1
                geom=varargin{1};
                if isa(geom,'poly_geo')
                    nodes=geom.vertices;  
                    elems=delaunayn(nodes,{'Qt','Qz'}); % See Qhull man
                    PhysBD=[geom.edges, geom.bdid];                   
                else
                    error("Not enough input arguments.")
                end
            end
            
            if nargin==2
                nodes=varargin{1};
                elems=varargin{2};
                PhysBD=varargin{3};
            end
            
            msh.dim=size(nodes,2);
            msh.nodes=nodes;
            msh.elems=elems;
            msh.PhysBD=PhysBD;            
        end
        
    end
end
