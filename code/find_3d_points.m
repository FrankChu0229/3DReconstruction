function [points_3d, res_err] = find_3d_points(P1, P2, matches)

x1_h = [matches(:,1:2),ones(length(matches),1)]';
x2_h = [matches(:,3:4),ones(length(matches),1)]';

P = cell(length(matches),1);

for i=1:length(matches)
    P{i,1} = ...
[P1(1,1)-P1(3,1)*x1_h(1,i),P1(1,2)-P1(3,2)*x1_h(1,i),P1(1,3)-P1(3,3)*x1_h(1,i),P1(1,4)-P1(3,4)*x1_h(1,i);...
 P1(2,1)-P1(3,1)*x1_h(2,i),P1(2,2)-P1(3,2)*x1_h(2,i),P1(2,3)-P1(3,3)*x1_h(2,i),P1(2,4)-P1(3,4)*x1_h(2,i);...
 P2(1,1)-P2(3,1)*x2_h(1,i),P2(1,2)-P2(3,2)*x2_h(1,i),P2(1,3)-P2(3,3)*x2_h(1,i),P2(1,4)-P2(3,4)*x2_h(1,i);...
 P2(2,1)-P2(3,1)*x2_h(2,i),P2(2,2)-P2(3,2)*x2_h(2,i),P2(2,3)-P2(3,3)*x2_h(2,i),P2(2,4)-P2(3,4)*x2_h(2,i)];
end

XYZW = [];
for i=1:length(matches)
    [U S V] = svd(P{i,1});
    n = size(V);
    XYZW(:,i) = V(:,n(2));
end

W = XYZW(4,:);
X = XYZW(1,:)./W;
Y = XYZW(2,:)./W;
Z = XYZW(3,:)./W;

points_3d = [X;Y;Z]';

err_t = [];
for i=1:length(matches)
    err_t(1,i) = sqrt(.5*((x1_h(1,i)-X(i)/Z(i))^2+(x1_h(2,i)-Y(i)/Z(i))^2+(x2_h(1,i)-X(i)/Z(i))^2+(x2_h(2,i)-Y(i)/Z(i))^2));
end

res_err = mean(err_t);

end