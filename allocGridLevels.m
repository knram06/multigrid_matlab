function ret = allocGridLevels(coarseGridPoints, numLevels)
ret = cell(numLevels, 1);

for i=1:numLevels
    numPoints = ((coarseGridPoints-1)*pow2(i-1))+1;
    
    % 3d points total - cubed
    ret{i} = zeros(numPoints, numPoints, numPoints);
end

end