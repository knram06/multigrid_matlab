function u = zero_out_neumann(u)
% Zeroes out Neumann nodes
%   Quick check - to see if we can get constant convergence
% RATIONALE: If adj boundary node had been kept fixed (like in Dirichlet)
% we would have got constant convergence. Maybe to reproduce that behavior,
% we can try this approach.

% try with 2D first
[NN, ~] = size(u);
N = uint32(sqrt(NN));

u = reshape(u, [N, N]);

for i=2:N-1
    u(i, 1) = 0;
    u(i, N) = 0;
end

u = reshape(u, [N*N, 1]);
end

