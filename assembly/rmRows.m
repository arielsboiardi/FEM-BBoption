function Mc=rmRows(M, DIRnodes)
% rmRows removes from input mass or stiffness matrix rows with indices of
% Dirichlet nodes. This operation is required as basis functions centered 
% on Dirichlet nodes are not used to test the solution. 
% 

Mc=M;
Mc(DIRnodes,:)=[];

end