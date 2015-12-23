function res = vcycle_iter(length, coarseGridPoints, numLevels, gsIterNum, useFMG)

% global alpha
% alpha = 1;
% global beta
% beta = 0;

% preallocate structure?
levelData(numLevels).level = numLevels;

for i=1:numLevels
    levelData(i).level = i;
    N                  = ((coarseGridPoints-1)*pow2(i-1)) + 1;
    h                  = length/(N-1);
    levelData(i).N     = N;
    levelData(i).h     = h;
    
    A                  = constructMatrix(N, h);
    [L,U]              = lu(A);
    levelData(i).A     = A;
    levelData(i).L     = tril(A, 0);  % referring Rajesh Gandham's code
    levelData(i).U     = triu(A, 1);  % referring Rajesh Gandham's code
    
    % soln and rhs vectors
    levelData(i).x     = zeros(N*N*N, 1);
    levelData(i).b     = zeros(N*N*N, 1);
end

levelData(numLevels).b = setupBoundaryConditions(levelData(numLevels).b, levelData(numLevels).h);

% call the mg method
% RELATIVE convergence criteria
toler = 1e-8;
[~,initNorm] = calc_residual(levelData(numLevels).A, levelData(numLevels).x, levelData(numLevels).b);
%edgesNorm = residual_edges(u{numLevels});

% enforce the Neumann after the residual calculation - so that it
% doesn't affect the initial residual calculation - HACK or legitimate?
%levelData(numLevels).b(end) = beta;

%initNorm = sqrt(initNorm*initNorm + edgesNorm*edgesNorm);
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
    [levelData, norm] = vcycle(levelData, numLevels, numLevels, gsIterNum);
    residRatio = norm/oldNorm;
    fprintf('%-10d %10.9g %10.9g\n', iterCount, norm, residRatio);
    iterCount = iterCount + 1;
end
toc;

res = levelData(numLevels).x;

%errNorm = compare_and_get_norm(res, h);
%fprintf('Error norm: %g\n', errNorm);

end

