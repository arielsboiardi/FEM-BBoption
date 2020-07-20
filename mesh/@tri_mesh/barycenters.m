function bc=barycenters(msh)
% barycenter computes the barycenters of all elements of a mesh
%
% bc=elem_barycenters(msh)
%
% Input:
%   msh: tri_mesh
% Output_:
%   bc: num_elems x dim matrix whose rows are barycenters of the element of
%   the mesh with the same index.
dim=size(msh.nodes,2);
nelems=size(msh.elems, 1);  % Total number of elements
bc=zeros(nelems,dim);       % Initialize matrix of barycenters
for idx=1:nelems
    bc(idx,:) = 1/(dim+1) * sum(msh.nodes(msh.elems(idx,:),:));
end
