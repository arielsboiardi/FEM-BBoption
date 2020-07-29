function wINIT = INITeval(initV, msh)
% INITeval evaluates the initial condition initV on all point of the mesh.

wINIT=initV(msh.nodes(:,1),msh.nodes(:,2));

end