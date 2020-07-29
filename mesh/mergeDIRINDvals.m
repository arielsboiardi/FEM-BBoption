function w = mergeDIRINDvals(wDIR, wIND, INDnodes)
% mergeDIRINDvals merges values of a function on Dirichlet and free nodes
% given the indices of the Dirichlet nodes.
%
% Input: 
%   wDIR: values of the function on Dirichlet nodes padded with zeors as
%   produced by function DIReval
%   wIND: values of the function on free nodes (not padded)
%   INDnodes: indices of free nodes
% 
% Output: 
%   w: values of function on all nodes
%
% NOTE:
%   - Can be made more efficient!

w = wDIR;
w(INDnodes) = wIND;

end