function A=Stiff(problem, msh)
% Stiff computes the stiffness matrix 

% The dimension of the approximation space is equal to the number of free
% vertices, that is thos that is, those without a boundary condition...
% Since I have not still implemented BCs I use all vertices. Furthermore I
% might be a good idea for the general implementation given th enon
% sequential nature of the basis functions...
N=size(msh.nodes,1); 

A=zeros(N);    % Initialize to be zero
for Kdx = 1:size(msh.elems,1)
    AK=Stiff_loc(problem,Kdx,msh);
    for idx = 1:3
        for jdx = 1:3
            % Local index idx on K corresponds to msh.elems(Kdx,idx) in the
            % global ordering
            A(msh.elems(Kdx,idx),msh.elems(Kdx,jdx)) = ...
                A(msh.elems(Kdx,idx),msh.elems(Kdx,jdx)) + AK(idx,jdx);
        end
    end
end

end