function [residual, l2norm] = calc_residual(u, d, h)
%calc_residual calculates residual (d-Au) given d, u
% A is implicit in matrix free form

[xLen, yLen] = size(u);
hSq = h*h;

residual = zeros(xLen, yLen);
l2norm = 0;

% MATLAB stores in column major
% so change across k indices first!!
% iterate across inner nodes
for j=2:yLen-1
    for i=2:xLen-1
        val = d(i, j) ...
            -(...
            (u(i-1, j) + u(i+1, j) ...
            +u(i, j-1) + u(i, j+1) ...
            -4*u(i, j) )/hSq);

        residual(i, j) = val;
        l2norm = l2norm + val*val;
    end
end

l2norm = sqrt(l2norm);

end

