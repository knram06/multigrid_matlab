function [u, rnorm] = test_lu(length, numPoints)

global capVoltage;
capVoltage = 0;
global extrVoltage;
extrVoltage = -1350;
global center;
center = [length/2, length/2];

h = length/(numPoints-1);
d = zeros(numPoints, numPoints);
N = numPoints;
A = constructCoarseMatrix(N, h);
%[L,U] = lu(A);

d=setupBoundaryConditions(d, h);

% let midpoint of X-Face end be extractor voltage
%d(3, 2, 2) = -1350;

b = reshape(d, [N*N, 1]);
    
x = A\b;

% the x obtained will be a 1D-vector
% reshape into relevant matrix form
u = reshape(x, [N, N]);
    
%solnVec = xLevels{level};
%residualVec = bLevels{level};
[r, rnorm] = calc_residual(u, d, h);

%fprintf('ErrNorm: %10.9g\n', compare_and_get_norm(u, h));

end

