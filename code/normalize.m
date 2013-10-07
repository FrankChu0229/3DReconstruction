function [ T ] = normalize( x )
% Compute normalization matrix
%   Detailed explanation goes here
    % translation
    u = mean(x(:,[1 2]),1);
    
    % scaling by sigma/sqrt(2)
    sigma = mean(sqrt((x(:,1)-u(1)).^2+(x(:,2)-u(2)).^2))/sqrt(2);
    
    % final normalization matrix
    T = [1/sigma 0 -u(1)/sigma;
        0 1/sigma -u(2)/sigma;
        0 0 1];
end

