function u = test_gs(length, numPoints)
% Function to test Gauss-Seidel smoother

h = length/(numPoints-1);
u = zeros(numPoints, numPoints, numPoints);
d = zeros(numPoints, numPoints, numPoints);

u=setupBoundaryConditions(u, h);
[~, norm]=calc_residual(u, d, h);
toler=1e-6;
cmpNorm = norm*toler;

iterCount=1;
tic;
while(norm > cmpNorm)
    u = gauss_seidel_smoother(u, d, h, 1);
    [~, norm]=calc_residual(u, d, h);
    fprintf('%10d %10.9g\n', iterCount, norm);
    iterCount = iterCount+1;
end
toc;

errNorm = compare_and_get_norm(u, h);
fprintf('Error norm: %g\n', errNorm);

end

