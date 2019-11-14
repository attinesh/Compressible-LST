function [y_adapt, x_adapt] = gridstretch(y_in,x_in,tol)

n = size(x_in);
r = diff(x_in);
%% Grid refinement

ydiff1 = gradient(y_in);
% Interpolate to half grid spacing

x_half = min(x_in):r(1,1)/2:max(x_in);
y_half = interp1(x_in,y_in,x_half,'spline');

% Find new half-grid gradient

ydiff1_2 = gradient(y_half);

% Adaptive grid
x_adapt = x_in(1);
for i = 1:n(1,1)-1
    j = 1;
    
    ydifftemp1 = ydiff1_2(2*i-1); % Load half-grid gradient
    ydifftemp2 = ydiff1(i); % Load complete grid gradient
    
    if(abs(ydifftemp1 - ydifftemp2) < tol)&& (i ~= 1) % Check if the current gradient is sufficiently low  
        x_adapt = horzcat([x_adapt x_in(i)]); 
    end
    
    if abs(ydifftemp1 - ydifftemp2) > tol % Check if the current gradient error is high
        
        while abs(ydifftemp1 - ydifftemp2) > tol
            x_refined = x_in(i):r/(2*(j+1)):x_in(i+1);   % Reduce grid size by half
            y_refined = interp1(x_half,y_half,x_refined,'spline');
            ydiff_refined = gradient(y_refined);
            ydifftemp2 = ydifftemp1; 
            ydifftemp1 = ydiff_refined(1,1);
            j = j+1;
        end
    
    x_adapt = horzcat([x_adapt x_refined(1,1:end-1)]); % Add the refined grid points
    
    end
        
   
end

x_adapt = horzcat([x_adapt x_in(end)]);
y_adapt = interp1(x_in,y_in,x_adapt,'spline');
end