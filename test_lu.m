function [u, norm] = test_lu(length, numPoints)

global alpha;
alpha = 1;
global beta;
beta = 2;

h = length/(numPoints-1);
d = zeros(numPoints, 1);
N = numPoints;
A = constructCoarseMatrix(N, h);
[L,U] = lu(A);

d=setupBoundaryConditions(d, h);
d(end) = beta;

% let midpoint of X-Face end be extractor voltage
%d(3, 2, 2) = -1350;
    
u = U\(L\d);

%solnVec = xLevels{level};
%residualVec = bLevels{level};
[~, norm] = calc_residual(u, d, h);

%fprintf('ErrNorm: %10.9g\n', compare_and_get_norm(u, h));

end

