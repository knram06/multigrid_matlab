function d = restrict_residual(r, d)

nodalWeights = zeros(3,3,3);
nodalWeights(1,1,:) = [0.015625, 0.03125, 0.015625];
nodalWeights(1,2,:) = [0.03125, 0.0625, 0.03125];
nodalWeights(1,3,:) = [0.015625, 0.03125, 0.015625];

nodalWeights(2,1,:) = [0.03125, 0.0625, 0.03125];
nodalWeights(2,2,:) = [0.0625, 0.125, 0.0625];
nodalWeights(2,3,:) = [0.03125, 0.0625, 0.03125];

nodalWeights(3,1,:) = [0.015625, 0.03125, 0.015625];
nodalWeights(3,2,:) = [0.03125, 0.0625, 0.03125];
nodalWeights(3,3,:) = [0.015625, 0.03125, 0.015625];

[xLenC, yLenC, zLenC] = size(d);
%[xLenF, yLenF, zLenF] = size(r);

% TODO: not copying over boundary faces as they should be zero
% based on the method I have adopted - change later?
% or just use MATLAB vector syntax for this?
%d(1, :, :) = r(1, 


for kc=2:zLenC-1
    for jc=2:yLenC-1
        for ic=2:xLenC-1
            
            % we are effectively on the fine grid at coord
            % (2*ic-1, 2*jc-1, 2*kc-1)
            % local origin of cube centered at this would be
            % (2*ic-2, 2*jc-2, 2*kc-2), basically (-1,-1,-1) of everything
            i = 2*ic-2; j = 2*jc-2; k = 2*kc-2;

            % local var for calculating sum
            val = 0;
            for kStep = 0:2
                for jStep = 0:2
                    for iStep = 0:2
                        val = val + ...
                              (r(i+iStep, j + jStep, k + kStep) * ...
                               nodalWeights(iStep+1, jStep+1, kStep+1));
                    end
                end
            end % end of cube centered around fine grid cube with origin
            
            d(ic, jc, kc) = val;
        end
    end
end

end