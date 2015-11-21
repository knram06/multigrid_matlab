function [xLevels, norm] = vcycle(xLevels, bLevels, level, numLevels, spacing, gsIterNum, L, U)

% reset lower level soln to zero
if (level < numLevels)
    xLevels{level} = 0*xLevels{level};
end

% base case recursion
if (level == 1)
    [N, ~, ~] = size(bLevels{level});
    b = reshape(bLevels{level}, [N*N*N, 1]);
    
    x = U\(L\b);
    
    % the x obtained will be a 1D-vector
    % reshape into relevant matrix form
    xLevels{level} = reshape(x, [N, N, N]);
    
    %solnVec = xLevels{level};
    %residualVec = bLevels{level};
    norm = 0;
    return
end

% first smoothening
xLevels{level} = gauss_seidel_smoother(xLevels{level}, bLevels{level}, spacing, gsIterNum);

% calculate residual
[r, ~] = calc_residual(xLevels{level}, bLevels{level}, spacing);

% restriction
%bLevels{level-1} = simple_restrict_residual(r, bLevels{level-1});
bLevels{level-1} = restrict_residual(r, bLevels{level-1});

% recursive call
[xLevels, ~] = vcycle(xLevels, bLevels, level-1, numLevels, 2*spacing, gsIterNum, L, U);

% prolongate and correct
%xLevels{level} = simple_prolong_correct(xLevels{level-1}, xLevels{level});
xLevels{level} = prolong_correct_error(xLevels{level-1}, xLevels{level});

% second smoothening
xLevels{level} = gauss_seidel_smoother(xLevels{level}, bLevels{level}, spacing, gsIterNum);

[~, norm] = calc_residual(xLevels{level}, bLevels{level}, spacing);
%solnVec = xLevels{level};
%residualVec = bLevels{level};

end