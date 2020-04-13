% Direct Solver for Inviscid Compressible Flow using Chebyshev
% discretization

clear all; close all; format long

%% Define Grid and Velocity Profile parameters

% Grid
N = 100;
yoff = 20;
tol = 1e-6;
b = 1.252; %Stretching factor
% Velcoity Profile
lam_u = 1;
M1 = 0;
c = 0.5+0.001*1i;
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

%% Stretch the Grid (Not required for this method)

% [U_adapt, x_adapt] = gridstretch(U,x,1e-3);
% 
% rho_adapt = interp1(x,rho,x_adapt,'spline');
% T_adapt = interp1(x,T,x_adapt,'spline');


%% Tangent mapping

eta = atan((x)./(b))./(pi/2);

   
%% Define the A and B matrices in the generalized eigenvalue problem Ax = alpha^2 Bx


[A,B] = operatorfd(U,x,eta,rho,T,M1,c);


%% Get eigenvalues

D = inv(B)*A;

[V2,S2] = eig(D);

[V,S]=eig(A,B,'qz'); 
S=diag(S); 


figure(1)
plot(real(S),imag(S),'*')

figure(2)
plot(real(sqrt(S)),imag(sqrt(S)),'*')

figure(3)

plot(eta,U,'*')