function errNorm = compare_and_get_norm(u, h)

[xNum, yNum, zNum ]=size(u);

errNorm = 0.;
for k=1:zNum
    for j=1:yNum
        for i=1:xNum
            diff = u(i, j, k) - BCFunc((i-1)*h, (j-1)*h, (k-1)*h);
            errNorm = errNorm + diff*diff;        
        end
    end
end

errNorm = sqrt(errNorm);
end

