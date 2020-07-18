function show(msh, varargin)
% Plots the mesh msh
%
% Input:
%   msh: tri_mesh object to plot
%   varargin: graphical options fromt he MATLAB library

dim=msh.dim; 
if dim==2
    int_Tria=T.ConnectivityList(T.isInterior,:);
    patch('faces',int_Tria,'vertices',T.Points,...
        'FaceAlpha',0,'EdgeColor',[0.2,0.2,0.2],varargin{1:end})
elseif dim==3
    tetramesh(msh.elems, msh.nodes,'FaceAlpha',0,'EdgeColor',[0.2,0.2,0.2],varargin{1:end})
else
    error("Cannot work in dimension higher than 3 :( \n")
end

end