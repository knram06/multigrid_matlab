function arr = setupBoundaryConditions(arr, h)

[NN, ~] = size(arr);
N = sqrt(NN);

% global capRadius;
% global extrInnerRad;
% global extrOuterRad;
global capVoltage;
capVoltage = 0;
global extrVoltage;
extrVoltage = -1350;
%global center;


arr = 0*arr;
% set on X=0 face
for j=1:N
    nj = (j-1)*N;
    %ty = h*(j-1)-center(1);
    %rr = ty*ty + tz*tz;
    
    %if(rr <= capRadius*capRadius)
    arr(nj+1) = capVoltage;
    arr(nj+N) = extrVoltage;
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
