function ret = allocGridLevels(coarseGridPoints, numLevels)
ret = cell(numLevels, 1);

for i=1:numLevels
    numPoints = ((coarseGridPoints-1)*pow2(i-1))+1;
    
    % 1d points total - squared
    ret{i} = zeros(numPoints);
end

end