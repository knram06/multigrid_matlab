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
    nnk = NN*(k-1);
    for j=1:N
        nj = (j-1)*N;
        for i=1:N
            pos = nnk + nj + i;
            if(i == 1 || i == N || j == 1 || j == N || k == 1 || k == N)
                if(i == 1 || i == N)
                    mat(pos, pos) = 1;
                    
                % Neumann condition on Y and Z boundary planes
                else
                    selfCount = 0;
                    
                    if(j == 1)
                        mat(pos, pos+N) = -invH;
                        selfCount = selfCount + 1;
                    elseif(j == N)
                        mat(pos, pos-N) = -invH;
                        selfCount = selfCount + 1;
                    end
                    
                    if(k == 1)
                        mat(pos, pos+NN) = -invH;
                        selfCount = selfCount + 1;
                    elseif(k == N)
                        mat(pos, pos-NN) = -invH;
                        selfCount = selfCount + 1;
                    end
                    
                    % enforce the corner smoothing
                    if(selfCount ~= 0)
                        mat(pos, pos) = selfCount*invH;
                    else
                        mat(pos, pos) = invH;
                    end
                end
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

