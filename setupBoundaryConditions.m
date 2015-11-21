function arr = setupBoundaryConditions(arr, h)

[I, J, K] = size(arr);

% apply bc on X-Faces, 1 and N-1
for k = 1:K
    for j = 1:J
      arr(1, j, k) = BCFunc(0,       h*(j-1), h*(k-1));
      arr(I, j, k) = BCFunc(h*(I-1), h*(j-1), h*(k-1));
    end
end

% apply bc on Y-Faces
for k = 1:K
    for i = 1:I
      arr(i, 1, k) = BCFunc(h*(i-1), 0,       h*(k-1));
      arr(i, J, k) = BCFunc(h*(i-1), h*(J-1), h*(k-1));
    end
end

% apply bc on Z-Faces
for j = 1:J
    for i = 1:I
      arr(i, j, 1) = BCFunc(h*(i-1), h*(j-1), 0);
      arr(i, j, K) = BCFunc(h*(i-1), h*(j-1), h*(K-1));
    end
end
end
