function [levelData, norm] = vcycle(levelData, level, numLevels, gsIterNum)

global beta;

% reset lower level soln to zero
if (level < numLevels)
    levelData(level).x = 0*levelData(level).x;
end

% base case recursion
if (level == 1)
    % RHS fix for non-homogenous Neumann
    %bLevels{level}(end) = beta;
    A = levelData(level).A;
    b = levelData(level).b;
    levelData(level).x = A\b;
    
    %solnVec = xLevels{level};
    %residualVec = bLevels{level};
    [~, norm] = calc_residual(levelData(level).A, levelData(level).x, levelData(level).b);
    return
end

% first smoothening
levelData(level).x = gauss_seidel_smoother(levelData(level).x, levelData(level).b, levelData(level).L, ...
                                           levelData(level).U, gsIterNum);

% calculate residual
[r, norm1] = calc_residual(levelData(level).A, levelData(level).x, levelData(level).b);

% restriction
%bLevels{level-1} = simple_restrict_residual(r, bLevels{level-1});
levelData(level-1).b = restrict_residual(r, levelData(level-1).b);

% recursive call
[levelData, norm] = vcycle(levelData, level-1, numLevels, gsIterNum);

% prolongate and correct
%xLevels{level} = simple_prolong_correct(xLevels{level-1}, xLevels{level});
levelData(level).x = prolong_correct_error(levelData(level-1).x, levelData(level).x);

% second smoothening
levelData(level).x = gauss_seidel_smoother(levelData(level).x, levelData(level).b, levelData(level).L, levelData(level).U, gsIterNum);

[r2, norm] = calc_residual(levelData(level).A, levelData(level).x, levelData(level).b);
%solnVec = xLevels{level};
%residualVec = bLevels{level};

end