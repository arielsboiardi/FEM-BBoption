function wDIR=DIReval(BDcond, DIRnodes, DIRnodes_id, msh, t)
% DIReval evaluates the boundary conditions on the appropriate Dirichlet
% nodes of the mesh at time t.
%
% Input:
%   BDcond: cell array with boundary conditions as specified by the
%   problem_data class.
%   DIRnodes: list of Dirichlet nodes as produced by tri_mesh/GRPnodes
%   DIRnodes_id: DIRnodes boundary identifiers as from tri_mesh/GRPnodes
%   msh: tri_mesh with mesh information (nodes coordinates are needed)
%   t: time instant at which the BCs are computed
% Output:
%   wDIR: vector with values of boundary conditions on DIRnodes and zeros 
%   in entries corresponding to free nodes.
%
% NOTES:
%   - List of DIRnodes is given as input as it will be probably already
%   been computed elsewhere, and the operation is kind of costly.
%   Unfortunately this choice makes the use of this function a bit les
%   natural. 
%

nodes=msh.nodes; % Extract for efficiency
Nnodes=size(nodes, 1);
wDIR=zeros(Nnodes,1); % Initialize as column of zeros

for idx=1:size(DIRnodes, 2)
    ndx=DIRnodes(idx);  % Index of node in position idx in DIRnodes
    g=BDcond{DIRnodes_id(idx)}; % Correspoding BC
    wDIR(ndx) = g(nodes(ndx,1), nodes(ndx,2), t);
end

end