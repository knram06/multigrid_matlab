function d = simple_restrict_residual(r, d)

[xLenC, yLenC] = size(d);
%[xLenF, yLenF, zLenF] = size(r);

% TODO: not copying over boundary faces as they should be zero
% based on the method I have adopted - change later?
% or just use MATLAB vector syntax for this?
%d(1, :, :) = r(1, 

for jc=2:yLenC-1
    for ic=2:xLenC-1
        d(ic, jc) = r(2*ic-1, 2*jc-1);
    end
end

end