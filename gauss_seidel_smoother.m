function u = gauss_seidel_smoother(u, d, h, gsIterNum)
%Gauss Seidel smoother
% Does matrix free version of GS Smoother for 3d Laplacian
% stencil

[xLen, yLen, zLen] = size(u);
hSq = h*h;
invMultFactor=1/6;

% MATLAB stores in column major
% so change across k indices first!!

for count=1:gsIterNum
    for k=2:zLen-1
        for j=2:yLen-1
            for i=2:xLen-1
                u(i, j, k) = invMultFactor*...
                    (u(i-1, j, k) + u(i+1, j, k) ...
                    + u(i, j-1, k) + u(i, j+1, k) ...
                    + u(i, j, k-1) + u(i, j, k+1) ...
                    - hSq*d(i, j, k) );
            end
        end
    end
end

% TODO: enforce Neumann later

end

