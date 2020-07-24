function [Q, R, E_min]=RadEdRat(T)
% RadEdRat computes the radius-to-edge ratio of all simplices of the
% triangulation T. Optionaloutputs are R, radii of the simplices in T and
% E_min: minimum edge lenght of simplices in T.

% NOTE: R and E_min are given as optional outputs because they are needed
% here: maybe usefull write separate functions to compute them?

C=T.circumcenter;   % Circumcenters of sall simplices
[ntria,~]=size(T.ConnectivityList); % ntria number of simplices
for tdx=1:ntria
    t=T.ConnectivityList(tdx,:);     % Indices vertices of simplex tdx
    
    % I now chose one vertex of t and compute the radius of t
    vert_t=T.Points(t(1),:);
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
                elenght=norm(T.Points(vdx,:)-T.Points(wdx,:));
                if elenght < emin
                    emin=elenght;
                end
            end
        end
    end
    E_min(tdx)=emin;
end
Q=R./E_min;
end