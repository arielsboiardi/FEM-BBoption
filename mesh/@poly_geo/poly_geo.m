classdef poly_geo
    % poly_geo class for polygonal and polyhedral geometries identified by
    % vertices and edges. If it is relevant a list of boundary identifiers
    % is availlable.
    %
    % PROPERTIES:
    % Name      Description
    % dim       Dimension of the space
    % vertices  Matrix of vertices of the polygon or polyhedron, every row
    %           contains coordinates of an edge, the index of the vertex
    %           corepsonds to its row-index
    % edges     Matrix of connections: every row represents contains the
    %           indices of endpoints of an edge
    % bdid      Identifiers for the boundaries, needed to be able to
    %           distinguish boundaries and assign boundary conditions later
    %           on. Identifiers should be integer indices, corresponding to
    %           indices of boundary_conditions in the problem_data object.
    
    properties
        vertices    % Vertices of the polygonal geometry
        edges       % Edges of the poligonal geometry
        bdid        % Boundaries identifiers, also see boundary_conditions in problme_data class
        dim         % Dimension of the space embedding the geoemtry
    end
    
    methods
        
        function geom=poly_geo(vertices, edges, bdid)
            % Constructor of the class poly_geo
            
            %% Check input data
            if nargin==2
                bdid=[];
            end
            
            %% Check for vertices not in edges
            % In some instances it is useful to give more vertices that
            % those that are strictly needed to describe the polygon, it is
            % therefore needed to locate on which edges these extra
            % vertices are in order to keep track of boundary flags. 
            
            total_vx=size(vertices, 1); % number of vertices given
            vx_in_edges=unique(edges); % Vertices used in edges matrix
            if total_vx ~= numel(vx_in_edges)
                
                
                vx_notin_edges=setdiff(1:total_vx, vx_in_edges);
                for pdx=vx_notin_edges
                    % For all points, find the edge on which they lie
                    for edx=1:size(edges,1)
                        % The parallelogram in edge edx and segment between the
                        % first point of edx and the point pdx ha area given
                        % by the det of this matrix
                        Q=[reshape(vertices(pdx,:)-vertices(edges(edx,1),:),[],1),...
                            reshape(vertices(edges(edx,2),:)-vertices(edges(edx,1),:),[],1)];
                        if det(Q) == 0
                            % The point pdx lies on the edge edx: edx is
                            % replaeced by E1-pdx and p-E2, if needed boundary
                            % flags are set for the new edges
                            edges=[edges(1:edx-1, :);...
                                edges(edx,1) pdx;...
                                pdx edges(edx,2);
                                edges(edx+1:end, :)];
                            if ~isempty(bdid)
                                bdid=[bdid(1:edx); bdid(edx:end)];
                            end
                            % Once an edge containing the vertex has been
                            % found, no othe edges can contain it.
                            break
                        end
                    end
                end
            end
            
            %% Now assemble the poly_geo object
            geom.vertices=vertices;
            geom.edges=edges;
            geom.dim=size(vertices,2);
            geom.bdid=bdid;
        end
        
    end 
end