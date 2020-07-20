function show_labels(msh)
% show_labels shows the labels of nodes and elements of a mesh
%

dim=size(msh.nodes,2);

hold on
num_nodes = size(msh.nodes,1); % number of nodes
nodes_labels = arrayfun(@(n) {sprintf('V%d', n)}, (1:num_nodes)');
pos=arrayfun(@(n) msh.nodes(:,n), (1:dim)', 'UniformOutput', false);
text(pos{1:dim}, nodes_labels, 'FontWeight', ...
    'bold', 'HorizontalAlignment','center', 'BackgroundColor', ...
    'none');


% Labels fro elements will be placed in the barycenters
C=msh.barycenters;

num_elems = size(msh.elems,1);  % number of elements
ele_labels = arrayfun(@(P) {sprintf('T%d', P)}, (1:num_elems)');
pos=arrayfun(@(n) C(:,n), (1:dim)', 'UniformOutput', false);
text(pos{1:dim},ele_labels,'FontWeight','bold', ...
    'HorizontalAlignment','center','Color','blue');
hold off

end