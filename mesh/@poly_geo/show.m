function show(geom, varargin)
% Plots geometry of hte domain with facecolor and edgecolor
% given and othe graphical settings in varargin following the
% standard MATLAB grpahic library syntax.

patch('faces',geom.edges,'vertices',geom.vertices,...
    varargin{1:end})

if geom.dim==3
    view(3)
end
axis image off

end