function [residual, l2norm] = calc_residual(A, x, b)
%calc_residual calculates residual (d-Au) given d, u

residual = b - A*x;
l2norm = norm(residual, 2);

end