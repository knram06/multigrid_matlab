function u = smooth_edge_values(u)
% smooth_edge_values: smoothen Neumann node locations
%   Makes it consistent with matrix construction

[xLen, yLen, zLen] = size(u);

% smooth the corner points
% 4 X lines on X plane
for i=2:xLen-1
    u(i, 1, 1)    = 0.5*(u(i, 2, 1) + u(i, 1, 2));
    u(i, yLen, 1) = 0.5*(u(i, yLen-1, 1) + u(i, yLen, 2));
    
    u(i, 1, zLen)    = 0.5*(u(i, 2, zLen) + u(i, 1, zLen-1));
    u(i, yLen, zLen) = 0.5*(u(i, yLen-1, zLen) + u(i, yLen, zLen-1));
end

% 4 Y lines on Y plane
for j=2:yLen-1
    u(1, j, 1)    = 0.5*(u(2, j, 1) + u(1, j, 2));
    u(xLen, j, 1) = 0.5*(u(xLen-1, j, 1) + u(xLen, j, 2));
    
    u(1, j, zLen)    = 0.5*(u(2, j, zLen) + u(1, j, zLen-1));
    u(xLen, j, zLen) = 0.5*(u(xLen-1, j, zLen) + u(xLen, j, zLen-1));
    
end

% 4 Z lines on Z plane
for k=2:zLen-1
    u(1, 1, k)    = 0.5*(u(2, 1, k) + u(1, 2, k));
    u(1, yLen, k) = 0.5*(u(2, yLen, k) + u(1, yLen-1, k));
    
    u(xLen, 1, k)    = 0.5*(u(xLen, 2, k) + u(xLen-1, 1, k));
    u(xLen, yLen, k) = 0.5*(u(xLen, yLen-1, k) + u(xLen-1, yLen, k));
end

% the 8 remaining corners (because they are all on common Neumann edges)
% 4 corners on X=0 face
u(1, 1, 1)    = (1/3) * (u(2, 1, 1) + u(1, 2, 1) + u(1, 1, 2));
u(1, yLen, 1) = (1/3) * (u(2, yLen, 1) + u(1, yLen-1, 1) + u(1, yLen, 2));

u(1, 1, zLen)    = (1/3) * (u(2, 1, zLen) + u(1, 2, zLen) + u(1, 1, zLen-1));
u(1, yLen, zLen) = (1/3) * (u(2, yLen, zLen) + u(1, yLen-1, zLen) + u(1, yLen, zLen-1));

% 4 corners on X=END face
u(xLen, 1, 1)    = (1/3) * (u(xLen-1, 1, 1) + u(xLen, 2, 1) + u(xLen, 1, 2));
u(xLen, yLen, 1) = (1/3) * (u(xLen-1, yLen, 1) + u(xLen, yLen-1, 1) + u(xLen, yLen, 2));

u(xLen, 1, zLen)    = (1/3) * (u(xLen-1, 1, zLen) + u(xLen, 2, zLen) + u(xLen, 1, zLen-1));
u(xLen, yLen, zLen) = (1/3) * (u(xLen-1, yLen, zLen) + u(xLen, yLen-1, zLen) + u(xLen, yLen, zLen-1));

end

