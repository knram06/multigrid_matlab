function arr = setupBoundaryConditions(arr, h)

[I, ~] = size(arr);

global alpha;
global beta;

arr(1) = alpha;
arr(I) = beta;

end
