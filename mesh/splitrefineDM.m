function Tr=splitrefineDM(T)
% splitrefDM refines the Delaunay triangulation T by splitting edges in
% half. 

% NOTE: This is by far not the best refinment aglgorithm, but is decent
% enough for our purpous

edges_indices=T.edges;
midpts=0.5*(T.Points(edges_indices(:,1),:)+T.Points(edges_indices(:,2),:));

[~,dim]=size(T.Points);
if dim==2
    Tr=delaunayTriangulation([T.Points; midpts], T.Constraints);
elseif dim==3
    Tr=delaunayTriangulation([T.Points; midpts]);
else
    error("Check your mesh! \n")
end

end
