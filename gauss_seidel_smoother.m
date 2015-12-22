function x = gauss_seidel_smoother(x, b, L, U, gsIterNum)
%Gauss Seidel smoother
% Does matrix free version of GS Smoother for 1d Laplacian
% stencil

% MATLAB stores in column major
% so change across k indices first!!

% DID NOT WORK: TEST: try zeroing out Neumann nodes and see if that helps
%u = zero_out_neumann(u);

for count=1:gsIterNum
    r = b - U*x;
    x = L\r;
end % end of smoother count loop

% smooth edge values
%u = smooth_edge_values(u);

end

