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

[NNN, ~] = size(r);
Nf = NNN^(1/3);

[NNN, ~] = size(d);
Nc = NNN^(1/3);

% TODO: not copying over boundary faces as they should be zero
% based on the method I have adopted - change later?
% or just use MATLAB vector syntax for this?
%d(1, :, :) = r(1, 

NFNF = Nf*Nf;
NCNC = Nc*Nc;
for kc=2:Nc-1
    for jc=2:Nc-1
        for ic=2:Nc-1
            
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
                              (r(NFNF*(k + kStep-1) + NF*(j + jStep-1) + (i+iStep)) * ...
                               nodalWeights(iStep+1, jStep+1, kStep+1));
                    end
                end
            end % end of cube centered around fine grid cube with origin
            
            d(NCNC*(kc-1) + NC*(jc-1) + i) = val;
        end
    end
end

end