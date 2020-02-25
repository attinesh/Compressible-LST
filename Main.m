% Direct Solver for Inviscid Compressible Flow

clear all; close all; format long

%% Define Grid and Velocity Profile parameters

% Grid
N = 100;
yoff = 8;
tol = 1e-6;
b = 3; %Stretching factor
% Velcoity Profile
lam_u = 0.45;

%% Load Fluid Parameter Profiles

% Velocity Theroritical
[U1,U2,x1,x2] = Velocity(N,yoff,lam_u);

U = vertcat(U2,flipud(U1(1:end-1)));
x = vertcat(x2,flipud(x1(1:end-1)));

% Velocity Experimental

% Density

rho = ones(size(U,1),1);

% Temperature

T = ones(size(U,1),1);

%% Stretch the Grid

[U_adapt, x_adapt] = gridstretch(U,x,1e-3);

rho_adapt = interp1(x,rho,x_adapt,'spline');
T_adapt = interp1(x,T,x_adapt,'spline');


%% Cotangent mapping

eta = acot(-(x_adapt)./(b))./(2*pi);

% Continious form
for i = 1:size(eta,2)
    if eta(i) < 0
        etab(i) = (eta(i))+0.5;
    else 
        etab(i) = eta(i);
    end
end
plot(U_adapt,etab,'*')    
%% Define the A and B matrices in the generalized eigenvalue problem Ax = alpha Bx


% [A,B] = operatorfd(U_adapt,x_adapt,etab,rho_adapt,T_adapt,M1);
