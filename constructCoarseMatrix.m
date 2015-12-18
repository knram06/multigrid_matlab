function mat = constructCoarseMatrix(N, h)

global capRadius;
global extrInnerRad;
global extrOuterRad;
global center;

matDim = N*N*N;
mat = zeros(matDim, matDim);

invH = 1/h;
hSq = h*h;
invHsq = 1/hSq;

% cache some coeffs
oneCoeff = 1*invHsq;
sixCoeff = 6*invHsq;

NN = N*N;
for k=1:N
    nnk = NN*(k-1);
    for j=1:N
        nj = N*(j-1);
        for i=1:N
            
            pos = nnk + nj + i;
            if(i == 1 || i == N || j == 1 || j == N || k == 1 || k == N)
                if(i == N)
                    mat(pos, pos-1) = -1;
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

%                else
%                     % if j==0 or END
%                     selfCount = 0;
%                     if(j == 1)
%                         mat(pos, pos+N) = -1;
%                         selfCount = selfCount + 1;
%                     elseif (j == N)
%                         mat(pos, pos-N) = -1;
%                         selfCount = selfCount + 1;
%                     end
% 
%                     % if k==0 or END
%                     if(k == 1)
%                         mat(pos, pos+NN) = -1;
%                         selfCount = selfCount + 1;
%                     elseif(k == N)
%                         mat(pos, pos-NN) = -1;
%                         selfCount = selfCount + 1;
%                     end
% 
%                     % hacky way to adjust for corner coeffs
%                     %if(selfCount ~= 0)
%                     % selfCount is guaranteed to not be zero right?
%                     mat(pos, pos) = selfCount;
%                     %else
%                     %    mat(pos, pos) = 1;
%                     %end
                end
                mat(pos, pos) = 1;
            % if on interior points 
            else
                mat(pos, pos-NN) = oneCoeff; mat(pos, pos+NN) = oneCoeff;
                mat(pos, pos-N)  = oneCoeff; mat(pos, pos+N)  = oneCoeff;
                mat(pos, pos-1)  = oneCoeff; mat(pos, pos+1)  = oneCoeff;
                
                mat(pos, pos) = -sixCoeff;
            end
            
        end
    end
end % end of k loop


end

