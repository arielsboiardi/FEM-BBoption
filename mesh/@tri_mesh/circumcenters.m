function C=circumcenters(msh, elemdx)
% circumcenters computes the coordinates of the circumcenters of simplices
% of the mesh, if inices are given only circumncenters for the selected
% elements are computed.
%

nodes=msh.nodes;
elems=msh.elems; % Extract data for more eficient access

if nargin==2
    % If particular elements are selected, only consider them.
    elems = elems(elemdx, :);
end

% The vertices of the trinagle are
A = nodes(elems(:,1), :); 
B = nodes(elems(:,2), :);
C = nodes(elems(:,3), :);

% Now compute squared lenght of edges
a2 = sum((B-C).^2,2);
b2 = sum((C-A).^2,2);
c2 = sum((A-B).^2,2);

% Now the coordinates of the circumcenter are 
C=(a2.*(b2+c2-a2).*A + b2.*(c2+a2-b2).*B + c2.*(a2+b2-c2).*C)./...
    (a2.*(b2+c2-a2) + b2.*(c2+a2-b2) + c2.*(a2+b2-c2));

end