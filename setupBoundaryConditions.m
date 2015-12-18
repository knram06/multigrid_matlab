function arr = setupBoundaryConditions(arr, h)

[I, J, K] = size(arr);

global capRadius;
global extrInnerRad;
global extrOuterRad;
global capVoltage;
global extrVoltage;
global center;


arr = 0*arr;
% set on X=0 face
i = 1;
for k=1:K
    tz = h*(k-1)-center(2);
    for j=1:J
        ty = h*(j-1)-center(1);
        rr = ty*ty + tz*tz;
        
        %if(rr <= capRadius*capRadius)
        arr(i, j, k) = capVoltage;
        %end
    end
end

% set on X=(END) face
% i = I;
% for k=1:K
%     tz = h*(k-1)-center(2);
%     for j=1:J
%         ty = h*(j-1)-center(1);
%         rr = ty*ty + tz*tz;
%         
%         %if((rr > extrInnerRad*extrInnerRad) && (rr < extrOuterRad*extrOuterRad) )
%         arr(i, j, k) = extrVoltage;
%         %end
%         
%     end
% end


% % apply bc on X-Faces, 1 and N-1
% for k = 1:K
%     for j = 1:J
%       arr(1, j, k) = BCFunc(0,       h*(j-1), h*(k-1));
%       arr(I, j, k) = BCFunc(h*(I-1), h*(j-1), h*(k-1));
%     end
% end
% 
% % apply bc on Y-Faces
% for k = 1:K
%     for i = 1:I
%       arr(i, 1, k) = BCFunc(h*(i-1), 0,       h*(k-1));
%       arr(i, J, k) = BCFunc(h*(i-1), h*(J-1), h*(k-1));
%     end
% end
% 
% % apply bc on Z-Faces
% for j = 1:J
%     for i = 1:I
%       arr(i, j, 1) = BCFunc(h*(i-1), h*(j-1), 0);
%       arr(i, j, K) = BCFunc(h*(i-1), h*(j-1), h*(K-1));
%     end
% end

end
