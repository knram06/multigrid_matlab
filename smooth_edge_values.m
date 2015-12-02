function u = smooth_edge_values(u)
% smooth_edge_values: smoothen Neumann node locations
%   Makes it consistent with matrix construction

[xLen, yLen, zLen] = size(u);

% smooth the corner points
% 2 X lines on Y=0 Face
for i=2:xLen-1
    u(i, 1, 1)    = 0.5*(u(i, 2, 1) + u(i, 1, 2));
    u(i, yLen, 1) = 0.5*(u(i, yLen-1, 1) + u(i, yLen, 2));
    
    u(i, 1, zLen)    = 0.5*(u(i, 2, zLen) + u(i, 1, zLen-1));
    u(i, yLen, zLen) = 0.5*(u(i, yLen-1, zLen) + u(i, yLen, zLen-1));
end


end

