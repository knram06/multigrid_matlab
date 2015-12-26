function u = test_gs(length, numPoints)
% Function to test Gauss-Seidel smoother

global capRadius;
capRadius = 1.326e-3;
%capRadius = 0.044;
global extrInnerRad;
extrInnerRad = 1e-2;
%extrInnerRad = 0.333;
global extrOuterRad;
extrOuterRad = 1.4e-2;
%extrOuterRad = 0.4666;
global capVoltage;
capVoltage = 0;
global extrVoltage;
extrVoltage = -1350;
global center;
center = [length/2, length/2];

h = length/(numPoints-1);
u = zeros(numPoints, numPoints, numPoints);
d = zeros(numPoints, numPoints, numPoints);

d=setupBoundaryConditions(d, h);
%[~, norm]=calc_residual(u, d, h);
initNorm = norm(reshape(d, [numPoints*numPoints*numPoints, 1]), 2);
toler=1e-8;
cmpNorm = initNorm*toler;
rnorm = initNorm;

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

