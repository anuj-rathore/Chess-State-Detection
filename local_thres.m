function Z = local_thres(A)
x=size(A,1)/100
y=size(A,2)/100
x=int16(x);
y=int16(y);
A=imresize(A,[x*100 y*100]);
Z=zeros(size(im2bw(A,0.5)));
Z(:,:)=255;
Z=double(Z);
for i=0:24
    for j=0:24
        samp=A(i*x*4+1:(i+1)*x*4,j*y*4+1:(j+1)*y*4,:);
        thresh=graythresh(samp);
        sampl1=im2bw(samp,thresh);
            Z(i*x*4+1:(i+1)*x*4,j*y*4+1:(j+1)*y*4)=sampl1;
    end
end
% figure;imshow(Z);
end