function res = vcycle_iter(length, coarseGridPoints, numLevels, gsIterNum, useFMG)

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

finestGridPoints = ((coarseGridPoints-1)*pow2(numLevels-1)) + 1;
h = length/(finestGridPoints-1);      % finest level spacing
hc = length/(coarseGridPoints-1);     % coarse level spacing

% preallocate the grid level data
u = allocGridLevels(coarseGridPoints, numLevels);
d = allocGridLevels(coarseGridPoints, numLevels);

% enforce some bcs here
d{numLevels} = setupBoundaryConditions(d{numLevels}, h);

% TODO: store and preallocate A matrix - Store its LU?
A = constructCoarseMatrix(coarseGridPoints, hc);
[L,U] = lu(A);

% call the mg method
% RELATIVE convergence criteria
toler = 1e-6;
%[~,initNorm] = calc_residual(u{numLevels}, d{numLevels}, h);
% SLIGHT CHANGE in residual calculation
r = d{numLevels} - u{numLevels}; % temporary way to avoid doing r=b-A*x, anyways x is also zero at start
[rs, ~, ~] = size(r);
initNorm = norm(reshape(r, [rs*rs*rs, 1]),2);
cmpNorm = initNorm*toler;

rnorm = initNorm;
% do FMG initialization?
if(useFMG)
    [u, rnorm] = fmg_init(u, d, numLevels, hc, gsIterNum, 1, L, U);
end

iterCount = 0;
MAX_ITER = 500;
fprintf('%-10s %10s %10s\n', 'Iter', 'Norm', 'ResidRednRatio');
fprintf('%-10d %10.9g %10.9g\n', iterCount, rnorm, 1);
tic;
while((rnorm > cmpNorm) && (iterCount < MAX_ITER) )
    oldNorm = rnorm;
    [u, rnorm] = vcycle(u, d, numLevels, numLevels, h, gsIterNum, L, U);
    residRatio = rnorm/oldNorm;
    iterCount = iterCount + 1;
    fprintf('%-10d %10.9g %10.9g\n', iterCount, rnorm, residRatio);
end
toc;

if(iterCount == MAX_ITER)
    fprintf('Broke out of iteration loop due to MAX_ITER of %d\n', MAX_ITER);

res = u{numLevels};

%errNorm = compare_and_get_norm(res, h);
%fprintf('Error norm: %g\n', errNorm);

end



