function Q=Gauss_quad(f,K)
% 
%

Qt=quadtriangle(3,'Domain',K);

Npts=size(Qt.Points(:,2),1);
Q=0;
for idx=1:Npts
    Q = Q + Qt.Weights(idx)*f(Qt.Points(idx,1), Qt.Points(idx,2));
end

end