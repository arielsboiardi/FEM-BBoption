function [Q, R, Emin]=radedrat(msh, elemdx) 
% radedrat computes the ratios between the radius and the lenght ofthe 
% shortes edge of each simplex. Particaler elements can be selected.
%
% Input:
%   mhs: tri_mesh object 
%   elemds: elements of the mesh to compute the ratio for 
%
% Ouputs:
%   Q: vector with radius/edge ratio for each element
%   R: vector of radii 
%   Emin: vector of shortest edges 
% 
% Note: 
%   - Option outputs might have no use, but since they are computed it
%   const nothing to output them if asked. 
%

nodes=msh.nodes;
elems=msh.elems;
if nargin==2
    elems=elems(elemdx,:);
end

C = msh.circumcenters;   % Circumcenters of all simplices
Nelems = size(C,1);
R=zeros(Nelems,1); % Initialize 
Emin=zeros(Nelems,1);
for tdx=1:Nelems
    t=elems(tdx,:);     % Indices vertices of simplex tdx
    vert_t=nodes(t(1),:);  % coordinates of one vertex of t
    R(tdx)=norm(C(tdx,:)-vert_t);    % raidus of t
    
    % I now need to measure all the edges of t, that is I need to measure
    % the distance between all couples of points in t and save the smallest
    % of these values
    emin=Inf;    % minumum edge lenght, initialized as infinity
    for vdx=t
        for wdx=t
            if wdx ~= vdx
                % Compute the lenght of the edge connecting the vertices of
                % indices vdx and wdx as
                elenght=norm(nodes(vdx,:)-nodes(wdx,:));
                if elenght < emin
                    emin=elenght;
                end
            end
        end
    end
    Emin(tdx)=emin;
end
Q=R./Emin;
end