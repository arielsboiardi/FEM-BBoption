function [bdE, bdV] = boundary_edges(msh)
% boundary_edges compute the edges of the triangles  in msh that lie on the
% boundary of the domain. These are the edges that are in only one
% triangle, in 2D, and edges that lie on a boundary face in 3D. 
%
% Input:
%   msh     tri_mesh object  
% Output:
%   bdE     boundary edges
%   bdV     boundary nodes

% Extract data from T
nodes = msh.nodes;
dim = msh.dim;      % Dimension of the embedding space
elems = sort(msh.elems); % Need to sort because edges have sorted indices
n_elems = size(elems,1);  % Number of elements

% 3D version is in progress
if dim==3
    error("3D meshes are not yet supported :(")
end

% Find set of all edges 
E=mesh_edges(T);
n_edges=numel(E(:,1)); % Number of elemedges

% Find indices of edges of the mesh that lie on the boundary of the domain
bdE_indices=false(n_edges,1);   % Logical indexing is used here
for edx=1:n_edges % Try all edges
    count_e = 0;    % Counts the number of simplices edx is edge of
    for idx=1:dim+1
        for jdx=1:dim+1
            for rdx=1:n_elems
                if E(edx,:) == elems(rdx, [idx,jdx])
                    count_e = count_e + 1;
                end
            end
        end
    end
    
    if count_e == 1
        % Id edx is edge of only one simplex, it is on the boundary of the
        % domain
        bdE_indices(edx)= true;
    end
end

% Extract boundary edges from E using the indices quilt in the loop
bdE=E(bdE_indices,:);

% If needed find nodes on the boundary: it is sufficient to consider only
% one time every node.
if nargout==2
    bdV=unique(bdE);
end

end
    
    