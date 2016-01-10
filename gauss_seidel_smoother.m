function u = gauss_seidel_smoother(u, d, h, gsIterNum)
%Gauss Seidel smoother
% Does matrix free version of GS Smoother for 3d Laplacian
% stencil

global capRadius;
global extrInnerRad;
global extrOuterRad;
global center;

[xLen, yLen, zLen] = size(u);
hSq = h*h;
invMultFactor=1/6;

% enforce the Dirichlet nodal values
% on X = 0 and END planes
u = setDirichletNodes(u, d, h);

% MATLAB stores in column major
% so change across k indices first!!

for count=1:gsIterNum
    for k=2:zLen-1
        for j=2:yLen-1
            for i=2:xLen-1
                u(i, j, k) = invMultFactor*...
                    ( u(i-1, j, k) + u(i+1, j, k) ...
                    + u(i, j-1, k) + u(i, j+1, k) ...
                    + u(i, j, k-1) + u(i, j, k+1) ...
                    - hSq*d(i, j, k) );
                
                % update Neumann node with latest value
                % so as to keep residual at zero
                if( i==2 || i==xLen-1 )
                    tz = (k-1)*h - center(2);
                    ty = (j-1)*h - center(1);
                    rr = ty*ty + tz*tz;

                    % if on inner node adj to boundary
                    if(i==2)
                        if( rr > capRadius*capRadius )
                            u(1, j, k) = u(2, j, k);
                        end        
                    else
                        if( (rr < extrInnerRad*extrInnerRad) ...
                                 || ...
                            (rr > extrOuterRad*extrOuterRad) )
                            u(xLen, j, k) = u(xLen-1, j, k);
                        end
                    end

                end
                
                % if on Y=0 or END faces
                if( j == 2 )
                    u(i, 1, k) = u(i, 2, k);
                elseif( j == yLen-1)
                    u(i, yLen, k) = u(i, yLen-1, k);
                end
                
                % if on Z=0 or END faces
                if( k == 2)
                    u(i, j, 1) = u(i, j, 2);
                elseif( k == zLen-1 )
                    u(i, j, zLen) = u(i, j, zLen-1);
                end
                
            end % end of i loop
        end
    end
end % end of smoother count loop

u = smooth_edge_values(u);
end

