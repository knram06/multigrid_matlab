function d = restrict_residual(r, d)

nodalWeights = zeros(3,3);

nodalWeights(1,:) = [0.0625, 0.125, 0.0625];
nodalWeights(2,:) = [0.125,  0.25,  0.125];
nodalWeights(3,:) = [0.0625, 0.125, 0.0625];

[NN, ~] = size(d);
Nc = sqrt(NN);

[NN, ~] = size(r);
Nf = sqrt(NN);

% reshape for convenience
d = reshape(d, [Nc, Nc]);
r = reshape(r, [Nf, Nf]);

%[xLenF, yLenF, zLenF] = size(r);

% TODO: not copying over boundary faces as they should be zero
% based on the method I have adopted - change later?
% or just use MATLAB vector syntax for this?
%d(1, :, :) = r(1, 

for jc=2:Nc-1
    for ic=2:Nc-1
        
        % we are effectively on the fine grid at coord
        % (2*ic-1, 2*jc-1, 2*kc-1)
        % local origin of cube centered at this would be
        % (2*ic-2, 2*jc-2, 2*kc-2), basically (-1,-1,-1) of everything
        i = 2*ic-2; j = 2*jc-2;
        
        % local var for calculating sum
        val = 0;

        for jStep = 0:2
            for iStep = 0:2
                val = val + ...
                    (r(i+iStep, j+jStep) * ...
                    nodalWeights(iStep+1, jStep+1) );
            end
        end % end of cube centered around fine grid cube with origin
        
        d(ic, jc) = val;
    end
end

% reshape back to 1D vector
d = reshape(d, [Nc*Nc, 1]);

end