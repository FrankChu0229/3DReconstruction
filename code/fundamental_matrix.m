%function [ F res_err ] = fundamental_matrix( X )
% Compute the fundamental matrix
%   Detailed explanation goes here

% number of point correspondences
N = size(X,1);

% get normalization matrices
x1_0 = [X(:,[1 2]) ones(N,1)];
x2_0 = [X(:,[3 4]) ones(N,1)];
T1 = normalize(x1_0);
T2 = normalize(x2_0);

% perform normalization
x1 = x1_0*T1';
x2 = x2_0*T2';
A = [x1(:,1).*x2(:,1) x1(:,2).*x2(:,1) x2(:,1) x1(:,1).*x2(:,2)...
    x1(:,2).*x2(:,2) x2(:,2) x1(:,1) x1(:,2) ones(N,1)];
x1 = x1';
x2 = x2';
x1_0 = x1_0';
x2_0 = x2_0';

% find singular vector
[U_a,S_a,V_a] = svd(A);
m = size(V_a);

% find the singular vector with smallest singular value
f = V_a(:,m(2));
f = reshape(f,3,3)';

% set rank 2
[U,S,V] = svd(f);
n = size(V);
S(n(1),n(2)) = 0;
F = U*S*V';

% denormalization
F = T2'*F*T1;

% residual Error
epipolar1=F*x1_0;
epipolar2=F'*x2_0;

Z = zeros(1,N);
for i=1:N
    Z(i) = 0.5*((epipolar1(:,i)'*x2_0(:,i))^2/sum(epipolar1(:,i).^2)+(epipolar2(:,i)'*x1_0(:,i))^2/sum(epipolar2(:,i).^2));
end
res_err = mean(Z);

%end

