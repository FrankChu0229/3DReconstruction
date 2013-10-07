name = 'house'
data_dir = ['../data/' name];

% images
I1 = imread([data_dir '/' name '1.jpg']);
I2 = imread([data_dir '/' name '2.jpg']);

% K matrices
qq = load([data_dir '/' name '1_K.mat']); K1 = qq.K;clear qq;
qq = load([data_dir '/' name '2_K.mat']); K2 = qq.K;clear qq;

% corresponding points
matches = load([data_dir '/' name '_matches.txt']); 
% this is a N x 4 where:

% visualize matches (disable or enable this whenever you want)
if true
    figure;
    imshow([I1 I2]); hold on;
    plot(matches(:,1), matches(:,2), '+r');
    plot(matches(:,3)+size(I1,2), matches(:,4), '+r');
    line([matches(:,1) matches(:,3) + size(I1,2)]', matches(:,[2 4])', 'Color', 'r');
end