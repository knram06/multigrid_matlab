function res = vcycle_iter(length, coarseGridPoints, numLevels, gsIterNum, useFMG)

global capRadius;
%capRadius = 1.326e-5;
capRadius = 0.044;
global extrInnerRad;
%extrInnerRad = 1e-4;
extrInnerRad = 0.333;
global extrOuterRad;
%extrOuterRad = 1.4e-4;
extrOuterRad = 0.4666;
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
u{numLevels} = setupBoundaryConditions(u{numLevels}, h);

% TODO: store and preallocate A matrix - Store its LU?
A = constructCoarseMatrix(coarseGridPoints, hc);
[L,U] = lu(A);

% call the mg method
% RELATIVE convergence criteria
toler = 1e-8;
[~,initNorm] = calc_residual(u{numLevels}, d{numLevels}, h);
cmpNorm = initNorm*toler;

norm = initNorm;
% do FMG initialization?
if(useFMG)
    [u, norm] = fmg_init(u, d, numLevels, hc, gsIterNum, 1, L, U);
end

iterCount = 1;
fprintf('%-10s %10s %10s\n', 'Iter', 'Norm', 'ResidRednRatio');
tic;
while(norm >= cmpNorm)
    oldNorm = norm;
    [u, norm] = vcycle(u, d, numLevels, numLevels, h, gsIterNum, L, U);
    residRatio = norm/oldNorm;
    fprintf('%-10d %10.9g %10.9g\n', iterCount, norm, residRatio);
    iterCount = iterCount + 1;
end
toc;

res = u{numLevels};

errNorm = compare_and_get_norm(res, h);
fprintf('Error norm: %g\n', errNorm);

end



