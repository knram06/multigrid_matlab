function mat = constructMatrix(N, h)

matDim = N;
mat = zeros(matDim, matDim);

hSq = h*h;
invH = 1/h;
invHsq = 1/hSq;

% cache some coeffs
oneCoeff = 1*invHsq;
twoCoeff = 2*invHsq;

for i=1:N
    pos = i;
    if(i == 1 || i == N)
        mat(pos, pos) = 1;
        
        % Neumann condition
        if(i == N)
           mat(pos, pos-1) = -invH;
           mat(pos, pos)   =  invH;
        end 
    else
        mat(pos, pos-1) = oneCoeff; mat(pos, pos+1)  = oneCoeff;
        mat(pos, pos) = -twoCoeff;
    end
end

end

