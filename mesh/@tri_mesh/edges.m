function E=edges(msh)
% Computes edges of all si simplices of the mesh

d=msh.dim;  % Extract once for efficiency
E=[];       % Fix this efficiency issue
for idx=1:d+1
    for jdx=1:d+1
        if idx ~= jdx
            % Consider all combinations of different oclumns in
            % elems
            E=[E; msh.elems(:,[idx,jdx])];
        end
    end
end
% Now we need to remove all repeated lines:
E=sort(E,2);
E=unique(E,'rows');
end