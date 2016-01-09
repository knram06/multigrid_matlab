function [u, rnorm] = test_gs(length, numPoints)
% Function to test Gauss-Seidel smoother

global capVoltage;
capVoltage = 0;
global extrVoltage;
extrVoltage = -1350;
global center;
center = [length/2, length/2];

h = length/(numPoints-1);
u = zeros(numPoints, numPoints);
d = zeros(numPoints, numPoints);

d=setupBoundaryConditions(d, h);
rnorm=residual_edges(u, d, h);
toler=1e-8;
cmpNorm = rnorm*toler;

iterCount=1;
tic;
while(rnorm > cmpNorm)
    u = gauss_seidel_smoother(u, d, h, 1);
    [r, rnorm]=calc_residual(u, d, h);
    fprintf('%10d %10.9g\n', iterCount, rnorm);
    iterCount = iterCount+1;
end
toc;

%errNorm = compare_and_get_norm(u, h);
%fprintf('Error norm: %g\n', errNorm);

end

