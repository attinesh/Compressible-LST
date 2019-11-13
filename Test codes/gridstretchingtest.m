clear all; close all;


%% Test function

r = 0.08; % Step
x = -2:r:2;
n = size(x);
y = 0.5*(1+tanh(x));

figure(1)
plot(x,y) ;
hold on;

for i=1:n(2)
 plot([x(i),x(i)],[0, y(i)]);
 plot([-2,x(i)],[y(i), y(i)]);
end


figure(2)

ydiff1 = gradient(y);

plot(x,ydiff1,'-*')


%% Grid refinement

tol = 1e-2;

% Interpolate to half grid spacing

x_half = -2:r/2:2;
y_half = interp1(x,y,x_half,'spline');

% Find new half-grid gradient

ydiff1_2 = gradient(y_half);

% Adaptive grid
x_adapt = x(1);
for i = 1:n(1,2)-1
    j = 1;
    
    ydifftemp1 = ydiff1_2(2*i-1); % Load half-grid gradient
    ydifftemp2 = ydiff1(i); % Load complete grid gradient
    
    if(abs(ydifftemp1 - ydifftemp2) < tol) % Check if the current gradient is sufficiently low  
        x_adapt = horzcat([x_adapt x(1,i)]); 
    end
    
    if abs(ydifftemp1 - ydifftemp2) > tol % Check if the current gradient error is high
        
        while abs(ydifftemp1 - ydifftemp2) > tol
            x_refined = x(i):r/(2*(j+1)):x(i+1);   % Reduce grid size by half
            y_refined = interp1(x_half,y_half,x_refined,'spline');
            ydiff_refined = gradient(y_refined);
            ydifftemp2 = ydifftemp1; 
            ydifftemp1 = ydiff_refined(1,1);
            j = j+1;
        end
    
    x_adapt = horzcat([x_adapt x_refined(1,1:end-1)]); % Add the refined grid points
    
    end
        
   
end

x_adapt = horzcat([x_adapt x(1,end)]);
y_adapt = interp1(x,y,x_adapt,'spline');

figure(3)

plot(x_adapt,y_adapt,'-*')
hold on;

plot(x,y,'-d')


figure(4)

plot(x_adapt,y_adapt) ;
hold on;
n2 = size(x_adapt,2);
for i=1:n2
 plot([x_adapt(i),x_adapt(i)],[0, y_adapt(i)]);
 plot([-2,x_adapt(i)],[y_adapt(i), y_adapt(i)]);
end