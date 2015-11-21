function [xLevels, norm] = fmg_init( xLevels, bLevels, levels, coarseGridSpacing, gsIterNum, vCycleCount, L, U )

% start from coarse grid and solve exactly
[N, ~, ~] = size(xLevels{1});
coarseRHS = zeros(N, N, N);

% impose bcs on the coarse rhs vector
coarseRHS = setupBoundaryConditions(coarseRHS, coarseGridSpacing);

b = reshape(coarseRHS, [N*N*N, 1]);
x = U\(L\b);

% the x obtained will be a 1D-vector
% reshape into relevant matrix form
xLevels{1} = reshape(x, [N, N, N]);

% with the coarse level soln
% now iterate through and do relevant V-Cycles
spacing = coarseGridSpacing;
for l = 2:levels
    % update N and spacing
    N = 2*N-1;
    spacing = spacing/2;
    
    % interpolate soln from level (l-1) - passing in zeros vector
    % since we are not adding to previous soln
    xLevels{l} = prolong_correct_error(xLevels{l-1}, zeros(N,N,N));
    
    % impose bcs on this
    xLevels{l} = setupBoundaryConditions(xLevels{l}, spacing);
    
    % reset the previous level soln to zero -- so as not to interfere
    % with the V-Cycle
    xLevels{l-1} = zeros(size( xLevels{l-1} ));
    
    % do number of V-Cycles on this
    for vnum = 1:vCycleCount
        [xLevels, norm] = vcycle(xLevels, bLevels, l, levels, spacing, gsIterNum, L, U);
    end
    
end

% updated xLevels and norm must be returned here

end

