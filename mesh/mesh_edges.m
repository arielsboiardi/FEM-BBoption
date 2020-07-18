function E=mesh_edges(T)
% mesh_edges finds the edges delunayTriangulation

% NOTE: There is a library function that does the same, but I founda it was
% a useful exercise, also in the perspective of moving to a different data
% structure

d=numel(T.Points(1,:));  % Geometric dimension of the embedding
E=[];                   % Fix this efficiency issue
for idx=1:d+1
    for jdx=1:d+1
        if idx ~= jdx
            % Consider all combinations of different oclumns in
            % elems
            E=[E; T.ConnectivityList(:,[idx,jdx])];
        end
    end
end
% Now we need to remove all repeated lines:
E=sort(E,2);
E=unique(E,'rows');
end