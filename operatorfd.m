% Matrices
function [A,B] = operatorfd(U,x,eta,rho,temp,M1,c)

if size(U)~= size(x)~= size(rho) ~= size(temp)
    fprintf('ya fucked up')
    exit
end
%% Setup the coefficients at Gauss-Lobotto points

% Matrix size

N = size(U,1);

% Gauss-Lobotto points

y = zeros(N+1);
for i = 0:N
    y(i) = cos(pi*i/N);
end

% Evaluate coefficients at G-L points
U_gl = interp1(eta,U,y);
rho_gl = interp1(eta,rho,y);

% g matrix

g = (1./rho_gl) - (M1^2).*(U_gl - c).^2;

g_1 = (-gradient(rho_gl,y)./(rho.^2))- (M1^2).*(2.*(U_gl - c)).*gradient(U_gl,y);


% L matrix

L = (gradient(gradient(U_gl,y),y) - gradient(U_gl,y).*(g_1./g))./(U_gl-c);


% Chebyshev differentiation matrices

[D0,D1,D2] = Dmat(N);


%% Create A and B matrices
%B matrix

B = cat(3,[U;rho;zeros(N,1);zeros(N,1)], [temp./(rho*gamma*M1.^2);U ;zeros(N,1)], [zeros(N,1);zeros(N,1);U;zeros(N,1)],...
    [zeros(N,1); gamma-1./rho; zeros(N,1); U]);



%A matrix

A = cat();

end