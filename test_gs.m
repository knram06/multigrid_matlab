function [u, norm] = test_gs(length, numPoints)
% Function to test Gauss-Seidel smoother

h = length/(numPoints-1);
u = zeros(numPoints*numPoints, 1);
d = zeros(numPoints*numPoints, 1);
A = constructMatrix(numPoints, h);
L = tril(A, 0);
U = triu(A, 1);

d=setupBoundaryConditions(d, h);

[~, norm]=calc_residual(A, u, d);
toler=1e-8;
cmpNorm = norm*toler;

iterCount=1;
tic;
while(norm > cmpNorm)
    u = gauss_seidel_smoother(u, d, L, U, 1);
    [~, norm]=calc_residual(A, u, d);
    fprintf('%10d %10.9g\n', iterCount, norm);
    iterCount = iterCount+1;
end
toc;

%errNorm = compare_and_get_norm(u, h);
%fprintf('Error norm: %g\n', errNorm);

end

