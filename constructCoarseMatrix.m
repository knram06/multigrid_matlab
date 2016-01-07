function mat = constructCoarseMatrix(N, h)

global capRadius;
global extrInnerRad;
global extrOuterRad;
global center;

matDim = N*N;
mat = zeros(matDim, matDim);

hSq = h*h;
invH = 1/h;
invHsq = 1/hSq;

% cache some coeffs
oneCoeff = 1*invHsq;
fourCoeff = 4*invHsq;

for j=1:N
    nj = N*(j-1);
    for i=1:N
        pos = nj + i;
        if(i == 1 || i == N || j == 1 || j == N)
            mat(pos, pos) = 1;
            if(i==1 || i==N)
                %                     tz = (k-1)*h - center(2);
                %                     ty = (j-1)*h - center(1);
                %                     rr = ty*ty + tz*tz;
                %
                %                     if( i==1 )
                %                         if(rr >= capRadius*capRadius)
                %                             mat(pos, pos+1) = -1;
                %                             selfCount = selfCount + 1;
                %                         % impose Dirichlet diag value although it shouldn't
                %                         % affect
                %                         %else
                %                         %    mat(pos, pos) = 1;
                %                         end
                %                     else
                %                         if( (rr <= extrInnerRad*extrInnerRad)...
                %                                    ||...
                %                             (rr >= extrOuterRad*extrOuterRad) )
                %                             mat(pos, pos-1) = -1;
                %                             selfCount = selfCount + 1;
                %                         %else
                %                         %    mat(pos, pos) = 1;
                %                         end
                %                     end
                
                %end % end of if i==1 or N
                
            else
                mat(pos, pos) = invH;
                % if j==0 or END
                if(j == 1)
                    mat(pos, pos+N) = -invH;
                elseif (j == N)
                    mat(pos, pos-N) = -invH;
                end
            end
            
        else
            mat(pos, pos-N)  = oneCoeff; mat(pos, pos+N)  = oneCoeff;
            mat(pos, pos-1)  = oneCoeff; mat(pos, pos+1)  = oneCoeff;

            mat(pos, pos) = -fourCoeff;
        end
    end
end


end

