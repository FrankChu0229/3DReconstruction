% code snippet to calculate disparity
load('kinect.mat')
% plot the err vs z^2
plot(z.^2,err);
% linear regression to get the slope
p=polyfit(z.^2,err,1);
sigmad = p(1)*b*f