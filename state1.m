A=imread('test2.png');

BW=rgb2gray(A);
for i=1:10
A=imsharpen(A);
end
c=graythresh(BW);
BW=edge(BW,'canny',c);
figure;imshow(BW);
[H,T,R] = hough(BW);
P  = houghpeaks(H,1000);
lines = houghlines(BW,T,R,P,'FillGap',10,'MinLength',15);
figure, imshow(A), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

end
