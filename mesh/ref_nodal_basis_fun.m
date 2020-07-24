function N = ref_nodal_basis_fun(idx, x1, x2)
% ref_nodal_basis_fun computes the nodal basis functions on the reference
% element in (x1,x2).

switch idx
    case 1
        N = 1 - x1 - x2;
    case 2
        N = x1;
    case 3
        N = x2;
    otherwise
        error("Index out of range")
end

end
