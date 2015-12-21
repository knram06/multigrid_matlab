function u = gauss_seidel_smoother(u, d, h, gsIterNum)
%Gauss Seidel smoother
% Does matrix free version of GS Smoother for 1d Laplacian
% stencil

global beta;

[xLen, ~] = size(u);
hSq = h*h;
invMultFactor=1/2;

% MATLAB stores in column major
% so change across k indices first!!

% DID NOT WORK: TEST: try zeroing out Neumann nodes and see if that helps
%u = zero_out_neumann(u);

for count=1:gsIterNum
    for i=2:xLen-1
        u(i) = invMultFactor*(u(i-1) + u(i+1) - hSq*d(i));
    end % end of i loop
    
    % enforce the end point Neumann
    %u(xLen) = beta*h + u(xLen-1);
    
end % end of smoother count loop

% smooth edge values
%u = smooth_edge_values(u);

end

