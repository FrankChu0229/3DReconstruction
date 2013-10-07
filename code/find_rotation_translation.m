function [R t] = find_rotation_translation(E)

[U S V] = svd(E);

m = size(U);

t_1 = U(:,m(2));
t_2 = -t_1;

t = cell(2,1);
t{1,1} = t_1;
t{2,1} = t_2;

theta = pi()/2;
phi = -theta;

R_90 = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
R_neg_90 = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0; 0 0 1];

R_1 = U*R_90'*V';
R_2 = U*R_neg_90'*V';
R_3 =-U*R_90'*V';
R_4 =-U*R_neg_90'*V';

R_temp = [];
count = 0;
if round(det(R_1))==1
    R_temp = [R_temp; R_1];
    count = count + 1;
end

if round(det(R_2))==1
    R_temp = [R_temp; R_2];
    count = count + 1;
end

if round(det(R_3))==1
    R_temp = [R_temp; R_3];
    count = count + 1;
end

if round(det(R_4))==1
    R_temp = [R_temp; R_4];
    count = count + 1;
end

R = cell(count,1);

for i = 1:count
    R{i,1} = R_temp((3*i-2):(3*i),:);
end

end