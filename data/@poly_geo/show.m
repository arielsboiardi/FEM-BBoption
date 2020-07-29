function show(geom, varargin)
% Plots geometry of hte domain with facecolor and edgecolor
% given and othe graphical settings in varargin following the
% standard MATLAB grpahic library syntax.

patch('faces',geom.edges,'vertices',geom.vertices,...
    varargin{1:end})

BD_midpts=0.5*(geom.vertices(geom.edges(:,1),:)...
    + geom.vertices(geom.edges(:,2),:));

BD_labels=arrayfun(@(P) {sprintf('BD%d', P)}, geom.bdid');
pos=arrayfun(@(n) BD_midpts(:,n), (1:2)', 'UniformOutput', false);
text(pos{1:end}, BD_labels, 'FontWeight','bold', ...
    'HorizontalAlignment','center','Color','red');
axis image off

end