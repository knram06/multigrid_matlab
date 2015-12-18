function u = smooth_edge_values(u)
% smooth_edge_values: smoothen Neumann node locations
%   Makes it consistent with matrix construction

[xLen, yLen] = size(u);

% smooth the corner points
u(1, 1)    = 0.5*(u(2, 1) + u(1, 2));
u(xLen, 1) = 0.5*(u(xLen, 2) + u(xLen-1, 1));

u(1, yLen)    = 0.5*(u(1, yLen-1) + u(2, yLen));
u(xLen, yLen) = 0.5*(u(xLen-1, yLen) + u(xLen, yLen-1));

end

