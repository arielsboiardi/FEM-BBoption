function Mc=rmCols(M, DIRnodes)
% rmCols removes from input mass or stiffness matrix columns with indices 
% of Dirichlet nodes. 
% 

Mc=M;
Mc(:,DIRnodes)=[];

end