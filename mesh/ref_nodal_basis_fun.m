function N = ref_nodal_basis_fun(idx, x1, x2)
% ref_nodal_basis_fun cpmputes the nodal basis functions on the reference
% element

switch idx
    case 1
        N = 1 - x1 - x2;
    case 2
        N = x1;
    case 3
        N = x2;
    otherwise
        error("Selection out of range")
end

end
