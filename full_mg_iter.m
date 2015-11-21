function res = full_mg_iter( length, coarseGridPoints, numLevels, gsIterNum )
%full_mg_iter Top level wrapper for FMG

%finestGridPoints = ((coarseGridPoints-1)*pow2(numLevels-1)) + 1;
h = length/(coarseGridPoints-1);

% preallocate the grid level data
u = allocGridLevels(coarseGridPoints, numLevels);
d = allocGridLevels(coarseGridPoints, numLevels);

% enforce some bcs here
%u{numLevels} = setupBoundaryConditions(u{numLevels}, h);

% TODO: store and preallocate A matrix - Store its LU?
A = constructCoarseMatrix(coarseGridPoints);
[L,U] = lu(A);

% call the mg method
% RELATIVE convergence criteria
toler = 1e-8;
[~,initNorm] = calc_residual(u{numLevels}, d{numLevels}, h);
cmpNorm = initNorm*toler;

end

