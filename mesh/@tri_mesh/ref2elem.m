function B_K = ref2elem(msh,K)
% ref2elem produces the matrix that deforms the reference element into an
% element of the physical mesh
%
% Input: 
%   K: index of the element we want to map 
%   msh: tri_mesh of which said element is part of
%
% Output:
%   B_K: matrix that deforms the reference element into K
%

K = msh.elems(K,:); % The element K is the K-th row of the elems matrix;
% Let p_1, p_2, p_3 be the vertices of K
p1 = msh.nodes(K(1),:);
p2 = msh.nodes(K(2),:);
p3 = msh.nodes(K(3),:);
% The matrix B_K has differences of these poins as columns:
B_K = [reshape(p2-p1,2,1), reshape(p3-p1,2,1)];

end