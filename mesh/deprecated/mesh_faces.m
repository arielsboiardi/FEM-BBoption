function F=mesh_faces(T)
% mesh_faces finds faces of 3D delunayTriangulation

% NOTE: This is similar to mesh_edges, but is not natively supported by
% MATLAB

d=numel(T.Points(1,:)); % Gometric dimension of embeddig space
if d==2
    warning("Faces in 2D are edges ;)")
    F=mesh_edges(T);
    return
end

elems=T.ConnectivityList;
F=[];           % Bad for performance
for idx=1:d+1
    for jdx=1:d+1
        for kdx=1:d+1
            if idx ~= jdx && jdx ~= kdx && kdx ~= idx
                F=[F;elems(:,idx), elems(:,jdx), elems(:,kdx)];
            end
        end
    end
end

% Now remove duplicates
F=sort(F,2);
F=unique(F,'rows');

end