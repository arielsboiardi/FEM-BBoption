function M_K = Mass_loc(K, msh)
% Mass_loc computes the local mass matrix on the element of the mesh msh of
% index K 
%
% Input: 
%   K: index of the element we are comput M_K for
%   msh: mesh as a tri_mesh object
% 
% Output:
%   M_K: local mass matrix relative to element K
%
% NOTE:
%   - here the mesh is given as a tri_mesh object because after refining
%   the mesh, I no longer need (I hope) the additional features fo
%   delunayTriangulation class and relative methods.

% The mass matrix on the reference element is computed analytically
M = 1/24*ones(3,3);
M = M+eye(3).*M;

% We now have to rescale by the double area of the element K, that is the
% Jacobian determinant of the matrix  B_K which maps the reference element
% in K. 
B_K=msh.ref2elem(K);
M_K=abs(det(B_K))*M;

end