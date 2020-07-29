function [DIRnodes, DIRnodes_id,INDnodes] = GRPnodes(msh)
% GRPnodes groups Dirichlet and free nodes in the mesh, and saves boundary
% indentifiers corresponding to Dirichlet nodes. 
%
% Inputs:
%   msh: tri_mesh object with mesh information
% Outputs: 
%   DIRnodes: indices of Dirichlet nodes
%   DIRnodes_id: identifiers of the boundaries on which DIRnodes lie
%   INDnodes: indices of free nodes (only if asked)
%

[~, ordDIR]=sort(msh.PhysBD(:,3),'ascend');
BD=msh.PhysBD(ordDIR,:);

DIRnodes=BD(1,1:2);
DIRnodes_id=[BD(1,3), BD(1,3)];
for idx=1:size(msh.PhysBD,1)
    for jdx=1:2
        % Parse the first two collumns of BD element by element
        if nnz(DIRnodes==BD(idx,jdx))==0
            % If the node BD(idx,jdx) has not already been added to
            % DIRnodes
            DIRnodes=[DIRnodes, BD(idx,jdx)];
            DIRnodes_id=[DIRnodes_id, BD(idx,3)];
        end
    end
end

if nargout==3
    % Since this is by far the most costly computation, is performed only
    % if the output is required. The aproach of removing rowns and columns
    % e.g. in rmRows.m instead of extracting them allows to avoid computing
    % INDnodes!
    INDnodes=setdiff(1:size(msh.nodes,1),DIRnodes, 'stable');
end

end