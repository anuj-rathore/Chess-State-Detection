orig = imread('5.jpg');
orig=imresize(orig,0.15);
I=rgb2gray(orig);
I=imgaussfilt(I);
I=histeq(I);
orig=I;
% Compute edge image
BW = edge(I,'canny');

% Compute Hough transform
% [H theta rho] = hough(BW);


rho_res = ceil(size(orig,1)/500);
[H, theta, rho] = hough(BW);%, 'RhoResolution', 0.2);
P = houghpeaks(H,20, 'Threshold', 0.2*max(H(:)));
lines = houghlines(BW, theta, rho, P,  'MinLength', 0.1*size(orig,1),'FillGap',50);


% Find local maxima of Hough transform
% numpeaks = 19;
% thresh = ceil(0.1 * max(H(:)));
% P = houghpeaks(H,numpeaks,'threshold',thresh);
% 
% % Extract image lines
% lines = houghlines(BW,theta,rho,P,'FillGap',50,'MinLength',60);

%--------------------------------------------------------------------------
% Display results
%--------------------------------------------------------------------------
% Original image
figure; imshow(I);

% Edge image
figure; imshow(BW);

% Hough transform
figure;image(theta,rho,imadjust(mat2gray(H)),'CDataMapping','scaled');
hold on; colormap(gray(256));
plot(theta(P(:,2)),rho(P(:,1)),'o','color','b');

% Detected lines
figure; imshow(orig); hold on; n = size(I,2);

for k = 1:length(lines)
    % Overlay kth line
    x = [lines(k).point1(1) lines(k).point2(1)];
    y = [lines(k).point1(2) lines(k).point2(2)];
    line = @(z) ((y(2) - y(1)) / (x(2) - x(1))) * (z - x(1)) + y(1);
    plot([1 n],line([1 n]),'Color','g');
end
%--------------------------------------------------------------------------

% C=corner(I);
% figure;imshow(I);hold on
% plot(C(:,1),C(:,2),'g*');
% figure;hold on
hold on
for i=1:size(lines,2)
    l1(i,1)=lines(i).point1(1);
    l1(i,2)=lines(i).point1(2);
    l1(i,3)=lines(i).point2(1);
    l1(i,4)=lines(i).point2(2);
    X=[l1(i,1) l1(i,3)];
    Y=[l1(i,2) l1(i,4)];
    plot(X,Y)
 end
for i=1:size(lines,2)
    for j=i+1:size(lines,2)
        [a(i,j),b(i,j)]=lineintersect(l1(i,:),l1(j,:));
    end
end
[row, col] = find(isnan(a));
figure;hold on
for i=1:size(lines,2)
    X=[l1(i,1) l1(i,3)];
    Y=[l1(i,2) l1(i,4)];
    plot(X,Y)
   for j=i+1:size(lines,2)
    if(size(find(row==i))==0&size(find(col==j))==0)
       temp='no' 
    else
        plot(a(i,j),b(i,j),'+');
    end
   end
end
