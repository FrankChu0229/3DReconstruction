function[] = plot_3d(pts,t)

figure(2);

hold on
scatter3(pts(:,1),pts(:,2),pts(:,3),'b'); axis on; xlabel('x'); ylabel('y'); zlabel('z');
scatter3([0;t(1)],[0;t(2)],[0;t(3)],'r'); axis on; xlabel('x'); ylabel('y'); zlabel('z');

end