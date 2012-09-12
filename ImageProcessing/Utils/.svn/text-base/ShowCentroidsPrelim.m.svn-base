function ShowCentroidsPrelim(Image)

s = regionprops(Image,'Centroid');
centroids = cat(1,s.Centroid);
hold on
plot(centroids(:,1),centroids(:,2),'b*')
hold off

end