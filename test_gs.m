function [u, norm] = test_gs(length, numPoints)
% Function to test Gauss-Seidel smoother

global alpha;
alpha = 1;
global beta;
beta = 2;

h = length/(numPoints-1);
u = zeros(numPoints, 1);
d = zeros(numPoints, 1);

u=setupBoundaryConditions(u, h);

% enforce end point Neumann
d(end) = beta;

[~, norm]=calc_residual(u, d, h);
toler=1e-10;
cmpNorm = norm*toler;

iterCount=1;
tic;
while(norm > cmpNorm)
    u = gauss_seidel_smoother(u, d, h, 1);
    [r, norm]=calc_residual(u, d, h);
    fprintf('%10d %10.9g\n', iterCount, norm);
    iterCount = iterCount+1;
end
toc;

%errNorm = compare_and_get_norm(u, h);
%fprintf('Error norm: %g\n', errNorm);

end

