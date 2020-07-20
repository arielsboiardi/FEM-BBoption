function NK=nodal_basis_fun(msh, K, idx, s1, s2)
% nodal_basis_fun computes the local nodal  basis functions for elements of
% a 2D mesh
    
BK=msh.ref2elem(K);
X=BK\([s1; s2] - msh.nodes(msh.elems(K,1),:)');
NK=ref_nodal_basis_fun(idx,X(1), X(2));

end