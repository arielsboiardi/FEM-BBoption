function w=INTERPlinear(msh, w_coefs, s1, s2)
% INTERPlinear interpolates data in the linear basis build on the mesh
%
% Inputs:
%   msh: tri_mesh object
%   w_coefs: coefficients of the function w.r.t the basis of the
%   approximation space
%   s1, s2: Point in which the approximation is computed
%




w=0;
for edx=1:size(msh.elems,1)
    for vdx=1:3
        if s1 == msh.nodes(msh.elems(edx, vdx),1) && ...
                s2 == msh.nodes(msh.elems(edx, vdx),2)
            w = w_coefs(msh.elems(edx,vdx));
            return
        end
        w = w + w_coefs(msh.elems(edx,vdx)) * ...
            msh.nodal_basis_fun(edx, vdx, s1, s2);
    end
end
