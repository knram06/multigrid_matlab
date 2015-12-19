function arr = setupBoundaryConditions(arr, h)

[I, J] = size(arr);

% global capRadius;
% global extrInnerRad;
% global extrOuterRad;
global capVoltage;
global extrVoltage;
%global center;


arr = 0*arr;
% set on X=0 face
for j=1:J
    %ty = h*(j-1)-center(1);
    %rr = ty*ty + tz*tz;
    
    %if(rr <= capRadius*capRadius)
    arr(1, j) = capVoltage;
    arr(I, j) = extrVoltage;
    %end
end

% for i=2:I-1
%     %ty = h*(j-1)-center(1);
%     %rr = ty*ty + tz*tz;
%     
%     %if(rr <= capRadius*capRadius)
%     arr(i, 1) = BCFunc((i-1)*h, 0);
%     arr(i, J) = BCFunc((i-1)*h, (J-1)*h);
%     %end
% end

end
