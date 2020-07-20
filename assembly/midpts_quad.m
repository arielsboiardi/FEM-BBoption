function Q=midpts_quad(f, K)
% midpts_quad perform a midpoints quadrature formula
%
% Q=midpts_quad(f, K) computes an approximation of the integral of f on
% the dim-simplex K by midpoints rule
%
% Input:
%   f: function handle to the integrand function (needs to be at least
%   formally dim-variate)
%   K: dim+1 x dim matrix where every line contains the coordinates of one
%   vertex
%
% Output:
%   Q: integral approximation

dim=size(K,2); % Space dimension

BK=zeros(dim);  %% MATRIX represent the triangle (its det is 2*area(K))
for cdx=1:dim
    BK(:,cdx) = reshape(K(cdx+1,:)-K(1,:), dim, 1);
end

m=[];   %% MIDPOINTS of edges
for idx = 1:dim+1
    for jdx = 1:dim+1
        if jdx ~= idx
            m=[m; reshape(0.5*(K(idx,:)+K(jdx,:)),1,dim)];
        end
    end
end
m=unique(m,'rows');

Q=0;
for idx=1:dim+1
    Q=Q+f(m(idx,1),m(idx,2)); %% FIX for 3D
end
Q = 0.5 * abs(det(BK))/3 * Q;

end