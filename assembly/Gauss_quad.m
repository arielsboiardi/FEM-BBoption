function Q=Gauss_quad(f,K)
% Gauss_quad computes the quadrature of a function on a triangle K descibed
% by its vertices by Gaussian quadrature of order 3. Depends n Quadtools by
% Ethan J. Kubatko:
% https://u.osu.edu/kubatko.3/codes_and_software/quadtools/
%

Qt=quadtriangle(3,'Domain',K);

Npts=size(Qt.Points(:,2),1);
Q=0;
for idx=1:Npts
    Q = Q + Qt.Weights(idx)*f(Qt.Points(idx,1), Qt.Points(idx,2));
end

end