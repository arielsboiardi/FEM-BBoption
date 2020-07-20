function p=show(msh, varargin)
% show plots the mesh
%
% Input:
%   msh: tri_mesh object to plot
% Optional inputs:
%   graphical options of the MATLAB library

dim=msh.dim;
if dim==2
    p=patch('faces',msh.elems,'vertices',msh.nodes,'FaceColor','w',...
        'FaceAlpha',0,'EdgeColor',[0.2,0.2,0.2],varargin{1:end});
elseif dim==3
    p=tetramesh(msh.elems, msh.nodes,'FaceColor','w',...
        'FaceAlpha',0,'EdgeColor',[0.2,0.2,0.2],varargin{1:end});
else
    error("Cannot work in dimension higher than 3 :(")
end

axis image off;

end