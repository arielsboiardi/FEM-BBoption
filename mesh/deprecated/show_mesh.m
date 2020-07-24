function show_mesh(T, varargin)
% show_mesh plots the triangulation T

if ~isa(T,'delaunayTriangulation')
    error("I need a delaunayTriangulation :( \n")
end

[~,dim]=size(T.Points);
if dim==2
    int_Tria=T.ConnectivityList(T.isInterior,:);
    patch('faces',int_Tria,'vertices',T.Points,...
        'FaceAlpha',0,'EdgeColor',[0.2,0.2,0.2],varargin{1:end})
elseif dim==3
    tetramesh(T,'FaceAlpha',0,'EdgeColor',[0.2,0.2,0.2],varargin{1:end})
else
    error("You cannot see in dimension higher that 3 :( \n")
end

end