close all;
clear;
clc;

I = imread('top.jpg');
I  = rgb2gray(I);

figure, 
imshow(I);
hold on

% I = histeq(I);
I = imsharpen(I,'Amount',1);
level = graythresh(I);

BW = edge(I,'canny',level);
[H,T,R] = hough(BW);

P  = houghpeaks(H,10000);
x = T(P(:,2)); y = R(P(:,1));


lines = houghlines(BW,T,R,P,'FillGap',1000,'MinLength',5);
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   m1 = xy(2,1) - xy(1,1);
   m2 = xy(2,2) - xy(1,2);
   plot([xy(1,1) xy(2,1)]+1e6*[-m1 m1],[xy(1,2) xy(2,2)]+1e6*[-m2 m2])
   
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
   
end
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');