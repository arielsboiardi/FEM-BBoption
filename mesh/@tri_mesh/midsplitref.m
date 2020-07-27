function rmsh=midsplitref(msh)
% midsplitref refines the mesh by splitting every edge in its mid point and
% triangulating the new sot of points by Delaunay triangulation. 
%

nodes=msh.nodes;    % Extract once for efficiency
edges=msh.edges;
Nvx=size(nodes,1);

BDedges=sort(msh.PhysBD(:,1:2),2);  % Edges of simplices that lie on the BD
INedges=setdiff(edges, BDedges, 'rows'); % Interior edges 

% Refine verttices set
BDmidpts=0.5*(nodes(BDedges(:,1),:)+nodes(BDedges(:,2),:));
INmidpts=0.5*(nodes(INedges(:,1),:)+nodes(INedges(:,2),:));

rnodes=[nodes; BDmidpts; INmidpts];
relems=delaunayn(rnodes,{'Qt','Qz'});

% Update physisical boundaries 
NBD=size(BDedges,1);
rPhysBD=[];
for edx=1:NBD
    BDedx=[msh.PhysBD(edx,1), Nvx+edx, msh.PhysBD(edx,3); ...
        Nvx+edx, msh.PhysBD(edx,2), msh.PhysBD(edx,3)];
    rPhysBD=[rPhysBD; BDedx]; 
end
% Build new mesh
rmsh=tri_mesh(rnodes, relems, rPhysBD);
end