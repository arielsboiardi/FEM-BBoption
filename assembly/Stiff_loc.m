function A_K=Stiff_loc(problem, K, msh)
% Stiff_local computes local stifness matrix for problem on an element of
% the mesh
%
% A=Stiff_local(problem, K, mesh)
%
% Input:
%   problem: problem_data object with problem information
%   K: index of an element of the mesh
%   msh: tri_mesh object with mesh information
%
% Output:
%   A_K: local stiffness matrix relative to element K

%% Construction
S=problem.cov_matrix; % Extract for easier notation
r=problem.rate;
% Define matrix D and vector b as in the paper
D=@(s1,s2) 0.5*S.*[s1.^2 s1.*s2; s1.*s2 s2.^2];
b=@(s1,s2) [s1.*(r- S(1,1) - S(1,2)*0.5);
            s2.*(r- S(2,2) - S(2,1)*0.5)];

% The gradient of nodal basis functions on the reference element are
% computed analytically an saved in a matrixe GradN, the the columns of
% which are gradient vectors of nodal basis functions
GradN=[[-1;-1], [1;0], [0;1]];

% The gradients of nodal basis functions are now computed relative to any
% element of the mesh as in the paper as B_K^{-T} GradN_i, this operation
% can be compacted with matrix operations
BK=msh.ref2elem(K);
GradNK=inv(BK)'*GradN;

% Element K ha vertices
K_vrts=msh.nodes(msh.elems(K,:),:);

%% Computation of integrals by mitpoint quadrature
A1=zeros(3,3); A2=zeros(3,3);
A3=r*Mass_loc(K,msh);
for idx=1:3
    for jdx=1:3 
%         A1(idx,jdx) = Gauss_quad(@(s1,s2) (D(s1,s2)*GradNK(:,jdx))'*GradNK(:,idx),K_vrts);
%         A2(idx,jdx) = Gauss_quad(@(s1,s2) (b(s1,s2)'*GradNK(:,jdx))*msh.nodal_basis_fun(K,idx,s1,s2), K_vrts);
%         Same results with Gauss quadrature ad midpts_quad
        A1(idx,jdx)=midpts_quad(@(s1,s2) (D(s1,s2)*GradNK(:,jdx))'*GradNK(:,idx),K_vrts);
        A2(idx,jdx)=midpts_quad(@(s1,s2) (b(s1,s2)'*GradNK(:,jdx))*msh.nodal_basis_fun(K,idx,s1,s2), K_vrts);
    end
end

A_K=A1-A2-A3;
end