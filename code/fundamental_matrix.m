%function [ F res_err ] = fundamental_matrix( X )
% Compute the fundamental matrix
%   Detailed explanation goes here

% number of point correspondences

N = size(X,1);

% get normalization matrices
x1 = [X(:,[1 2]) ones(N,1)];
x2 = [X(:,[3 4]) ones(N,1)];
T1 = normalize(x1);
T2 = normalize(x2);

% perform normalization
x1 = x1*T1';
x2 = x2*T2';
A = [x1(:,1).*x2(:,1) x1(:,2).*x2(:,1) x2(:,1) x1(:,1).*x2(:,2)...
    x1(:,2).*x2(:,2) x2(:,2) x1(:,1) x1(:,2) ones(N,1)];
x1 = x1';
x2 = x2';

[U_a,S_a,V_a] = svd(A);
m = size(V_a);

f = V_a(:,m(2));

F_uncorr = [];
for i = 1:length(f)
    col = rem(i,3);
    if col==0
        col = 3;
    end
    F_uncorr(ceil(i/3),col) = f(i);
end

%SVD
[U,S,V] = svd(F_uncorr);
%F correction
n = size(V);

S(n(1),n(2)) = 0;

F_corr = U*S*V';

%Denormalization
F = T2'*F_corr*T1;
%end

