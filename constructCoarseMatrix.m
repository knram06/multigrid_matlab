function mat = constructCoarseMatrix(N)
matDim = N*N*N;
mat = zeros(matDim, matDim);

NN = N*N;

for k=1:N
    nnk = NN*(k-1);
    for j=1:N
        nj = N*(j-1);
        for i=1:N
            pos = nnk + nj + i;
            if(i == 1 || i == N || j == 1 || j == N || k == 1 || k == N)
                mat(pos,pos) = 1;
            else
                mat(pos, pos-NN) = 1; mat(pos, pos+NN) = 1;
                mat(pos, pos-N)  = 1; mat(pos, pos+N)  = 1;
                mat(pos, pos-1)  = 1; mat(pos, pos+1)  = 1;
                
                mat(pos, pos) = -6;
            end
        end
    end
end % end of k loop

end

