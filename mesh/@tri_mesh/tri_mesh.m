classdef tri_mesh
    % Class for unstructured 2D and 3D triangular mesh
    
    properties
        nodes       % Vertices of the triangulation
        elems       % Descritpion of elements trhough connectivity matrix
        dim         % Geometric dimension of the embeddign space
    end
    
    methods
        
        function msh=tri_mesh(varargin)
            % Constructor of tri_mesh
            %
            % Input:
            %   nodes, elems:   Nodes and elemets matrices
            % OR
            %   T:              delunayTriangulation
            
            if nargin==1
                T=varargin{1};
                if isa(T,'delaunayTriangulation')
                    nodes=T.Points;
                    elems=T.ConnectivityList;
                else
                    error("Not enough input arguments \n")
                end
            end
            
            if nargin==2
                nodes=varargin{1};
                elems=varargin{2};
            end
            
            msh.dim=numel(nodes(1,:));
            msh.nodes=nodes;
            msh.elems=elems;
            
        end
        
    end
end
