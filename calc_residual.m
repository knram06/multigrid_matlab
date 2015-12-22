function [residual, l2norm] = calc_residual(u, d, h)
%calc_residual calculates residual (d-Au) given d, u
% A is implicit in matrix free form

[xLen, ~] = size(u);
hSq = h*h;

residual = zeros(xLen, 1);
l2norm = 0;

% MATLAB stores in column major
% so change across k indices first!!
% iterate across inner nodes
for i=2:xLen-1
    val = d(i) - ( (u(i-1) + u(i+1) -2*u(i))/hSq);
    
    residual(i) = val;
    l2norm = l2norm + val*val;
end
l2norm = sqrt(l2norm);

end

