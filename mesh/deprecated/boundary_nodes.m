function bdV=boundary_nodes(T)
% boundary_nodes finds the nodes fo the triangulation T that lie on the
% boundary of the domain, these are the nodes that define boundary edges.

bdE=boundary_edges(T);
bdV=unique(reshape(bdE,[],1));

end