function arr = setupBoundaryConditions(arr, h)

[NNN, ~] = size(arr);

N = NNN^(1/3);

% apply bc on X-Faces, 1 and N-1
for k = 1:N
    for j = 1:N
      arr(1, j, k) = BCFunc(0,       h*(j-1), h*(k-1));
      arr(N, j, k) = BCFunc(h*(N-1), h*(j-1), h*(k-1));
    end
end

% apply bc on Y-Faces
for k = 1:N
    for i = 1:N
      arr(i, 1, k) = BCFunc(h*(i-1), 0,       h*(k-1));
      arr(i, N, k) = BCFunc(h*(i-1), h*(N-1), h*(k-1));
    end
end

% apply bc on Z-Faces
for j = 1:N
    for i = 1:N
      arr(i, j, 1) = BCFunc(h*(i-1), h*(j-1), 0);
      arr(i, j, N) = BCFunc(h*(i-1), h*(j-1), h*(N-1));
    end
end

end
