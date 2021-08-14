function J = finite_finite_pendulum_cost(x, h)
% simple finite-difference derivatives
% assumes the function fun() is vectorized

if nargin < 2
    h = 2^-17;
end

[n1, K1]  = size(x);
H       = [zeros(n1,1) h*eye(n1)];
H       = permute(H, [1 3 2]);
X       = pp(x, H);
X       = reshape(X, n1, K1*(n1+1));

[n2, K2]  = size(X);
H       = [zeros(n2,1) h*eye(n2)];
H       = permute(H, [1 3 2]);
X       = pp(X, H);
X       = reshape(X, n2, K2*(n2+1));

Y       = pendulum_cost(X(1:2,:), X(3,:));

m       = numel(Y)/(K2*(n2+1));
Y       = reshape(Y, m, K2, n2+1);
J       = pp(Y(:,:,2:end), -Y(:,:,1)) / h;
J       = permute(J, [1 3 2]);

Y       = squeeze(J);

m       = numel(Y)/(K1*(n1+1));
Y       = reshape(Y, m, K1, n1+1);
J       = pp(Y(:,:,2:end), -Y(:,:,1)) / h;
J       = permute(J, [1 3 2]);

end

