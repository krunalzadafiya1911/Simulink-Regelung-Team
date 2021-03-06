function J = finite_difference_pendulum_cost(x, xn, h)
%% finite_difference_pendulum_cost  function: simple finite-difference derivatives
  % assumes the function fun() is vectorized

%% ******** Owner of Code ************************************************
  % Krunalkumar, Zadafiya (TU Kaiserslautern)
  %
  % Author: zadafiya@rhrk.uni-kl.de
  % **********************************************************************
  % Begin initializataion code - DO NOT EDIT
  
if nargin < 3
    h = 2^-17;
end

[n, K]  = size(x);
H       = [zeros(n,1) h*eye(n)];
H       = permute(H, [1 3 2]);
X       = pp(x, H);
X       = reshape(X, n, K*(n+1));
Y       = pendulum_cost(X(1:2,:), X(3,:), xn);
m       = numel(Y)/(K*(n+1));
Y       = reshape(Y, m, K, n+1);
J       = pp(Y(:,:,2:end), -Y(:,:,1)) / h;
J       = permute(J, [1 3 2]);
end