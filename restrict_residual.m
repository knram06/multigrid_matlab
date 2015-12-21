function d = restrict_residual(r, d)

[xLenC] = size(d);
%[xLenF, yLenF, zLenF] = size(r);

% TODO: not copying over boundary faces as they should be zero
% based on the method I have adopted - change later?
% or just use MATLAB vector syntax for this?
%d(1, :, :) = r(1, 

for ic=2:xLenC-1
    
    % we are effectively on the fine grid at coord
    % (2*ic-1, 2*jc-1, 2*kc-1)
    % local origin of cube centered at this would be
    % (2*ic-2, 2*jc-2, 2*kc-2), basically (-1,-1,-1) of everything
    i = 2*ic-2;
    d(ic, jc) = 0.25*r(i-1) + 0.5*r(i) + 0.25*r(i+1);
end

end