function mat = constructMatrix(N, h)

matDim = N*N*N;
mat = zeros(matDim, matDim);

hSq = h*h;
invH = 1/h;
invHsq = 1/hSq;

% cache some coeffs
oneCoeff  = 1*invHsq;
sixCoeff  = 6*invHsq;

NN = N*N;

for k=1:N
    nnk = NN*k;
    for j=1:N
        nj = (j-1)*N;
        for i=1:N
            pos = nnk + nj + i;
            if(i == 1 || i == N || j == 1 || j == N || k == 1 || k == N)
                mat(pos, pos) = 1;
                
%                 if(i == 1 || i == N)
%                     mat(pos, pos) = 1;
%                     
%                     % Neumann condition on Y planes
%                 else
%                     mat(pos, pos) = invH;
%                     if(j == 1)
%                         mat(pos, pos+N) = -invH;
%                     end
%                     
%                     if(j == N)
%                         mat(pos, pos-N) = -invH;
%                     end
%                 end
            else
                mat(pos, pos-NN) = oneCoeff; mat(pos, pos+NN) = oneCoeff;
                mat(pos, pos-N)  = oneCoeff; mat(pos, pos+N)  = oneCoeff;
                mat(pos, pos-1)  = oneCoeff; mat(pos, pos+1)  = oneCoeff;
                mat(pos, pos)    = -sixCoeff;
            end
        end % end of i loop
    end
end % end of k loop

end

