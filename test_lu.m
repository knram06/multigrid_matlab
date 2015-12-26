function [u, rnorm] = test_lu(length, numPoints)

global capRadius;
capRadius = 1.326e-5;
%capRadius = 0.044;
global extrInnerRad;
extrInnerRad = 1e-4;
%extrInnerRad = 0.333;
global extrOuterRad;
extrOuterRad = 1.4e-4;
%extrOuterRad = 0.4666;
global capVoltage;
capVoltage = 0;
global extrVoltage;
extrVoltage = -1350;
global center;
center = [length/2, length/2];

h = length/(numPoints-1);
d = zeros(numPoints, numPoints, numPoints);
N = numPoints;
A = constructCoarseMatrix(N, h);
[L,U] = lu(A);

d=setupBoundaryConditions(d, h);

% let midpoint of X-Face end be extractor voltage
%d(3, 2, 2) = -1350;

b = reshape(d, [N*N*N, 1]);
    
x = U\(L\b);

% the x obtained will be a 1D-vector
% reshape into relevant matrix form
u = reshape(x, [N, N, N]);
    
%solnVec = xLevels{level};
%residualVec = bLevels{level};
[~, rnorm] = calc_residual(u, d, h);

%fprintf('ErrNorm: %10.9g\n', compare_and_get_norm(u, h));

end

