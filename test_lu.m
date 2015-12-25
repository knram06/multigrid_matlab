function [u, norm] = test_lu(length, numPoints)

h = length/(numPoints-1);
d = zeros(numPoints*numPoints*numPoints, 1);
N = numPoints;
A = constructMatrix(N, h);
[L,U] = lu(A);

d=setupBoundaryConditions(d, h);

% let midpoint of X-Face end be extractor voltage
%d(3, 2, 2) = -1350;
    
u = U\(L\d);

%solnVec = xLevels{level};
%residualVec = bLevels{level};
[~, norm] = calc_residual(A, u, d);

%fprintf('ErrNorm: %10.9g\n', compare_and_get_norm(u, h));

end

