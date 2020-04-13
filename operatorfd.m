% Matrices
function [A,B] = operatorfd(U,x,eta,rho,temp,M1,c)

if size(U)~= size(x)~= size(rho) ~= size(temp)
    fprintf('Matrix sizes are not the same')
    exit
end
%% Setup the coefficients at Gauss-Lobotto points

% Matrix size

N = size(U,1);

% Gauss-Lobotto points

y = zeros(N+1,1);
for i = 0:N
    y(i+1,1) = cos(pi*i/N);
end

% Evaluate coefficients at G-L points
U_gl = interp1(eta,U,y,'spline');
rho_gl = interp1(eta,rho,y,'spline');

% g matrix

g = (1./rho_gl) - (M1^2).*(U_gl - c).^2;

g_1 = (-gradient(rho_gl,y)./(rho_gl.^2))- (M1^2).*(2.*(U_gl - c)).*gradient(U_gl,y);


% L matrix                               

L = (gradient(gradient(U_gl,y),y) - gradient(U_gl,y).*(g_1./g))./(U_gl-c);


% Chebyshev differentiation matrices

[D0,D1,D2] = Dmat(N);


%% Create A and B matrices (Full Problem)

% %B matrix
% 
% B11 = (rho_gl'.*g').*D0;
% B = [D0(1,:); D1(1,:); B11(3:N-1,:); D1(N+1,:); D0(N+1,:)];
% 
% %A matrix
% er = -200*1i;
% A11 = D2-(g_1./g)'*D1 - L'*D0; 
% A  = [er.*D0(1,:); er.*D1(1,:);  A11(3:N-1,:); er.*D1(N+1,:); er.*D0(N+1,:)];

%% Create A and B matrices (Invisid incompressible problem - Michalke)

%B matrix

B11 = D0;
B = [D0(1,:); B11(2:N,:); D0(N+1,:)];

%A matrix
er = -200*1i;
A11 = D2 - L.*D0; 
A  = [er.*D0(1,:);  A11(2:N,:); er.*D0(N+1,:)];

end