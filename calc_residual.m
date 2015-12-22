function [residual, l2norm] = calc_residual(A, x, b)
%calc_residual calculates residual (d-Au) given d, u
% A is implicit in matrix free form

residual = b - A*x;
l2norm = norm(residual, 2);

end

