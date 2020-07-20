function M=Mass(msh)
% Mass computes the mass matrix given by the L2 products of basis functions
% relative to the mesh msh.

% The dimension of the approximation space is equal to the number of free
% vertices, that is thos that is, those without a boundary condition...
% Since I have not still implemented BCs I use all vertices. Furthermore I
% might be a good idea for the general implementation given th enon
% sequential nature of the basis functions...
N=size(msh.nodes,1); 

M=zeros(N);    % Initialize to be zero
for Kdx = 1:size(msh.elems,1)
    MK=Mass_loc(Kdx,msh);
    for idx = 1:3
        for jdx = 1:3
            % Local index idx on K corresponds to msh.elems(Kdx,idx) in the
            % global ordering
            M(msh.elems(Kdx,idx),msh.elems(Kdx,jdx)) = ...
                M(msh.elems(Kdx,idx),msh.elems(Kdx,jdx)) + MK(idx,jdx);
        end
    end
end

end