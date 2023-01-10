function [img] = randomcurve(nsize,num1)


num = num1;
factor = randi([4 10]);
msize = nsize/factor;
xsize = nsize*2;
%folder_name='Curve\';

vertices=zeros(num,2);
figure;
for i=1:num   
    for jj=1:num
        vertices(1,jj)=round(xsize*rand(1,1));
        vertices(2,jj)=round(xsize*rand(1,1));
    end                 
    vertices=vertices';
    %NumPoint=size(vertices,2)-1;%点的个数
    NumPoint = round(num*2/3);
    t=1/xsize:1/xsize:1;
    x=(1-t).^(NumPoint)*vertices(i,1);
    y=(1-t).^(NumPoint)*vertices(i,2);
    for j=1:NumPoint
        w=factorial(NumPoint)/(factorial(j)*factorial(NumPoint-j))*(1-t).^(NumPoint-j).*t.^(j);
        x=x+w*vertices(1,j+1);
        y=y+w*vertices(2,j+1);
    end
    
    set(gcf,'position',[0,0,512,512])
    plot(x,y,'k','LineWidth',0.5);
    axis equal;
    axis tight;
    axis off;
    hold on;
end
    I=getframe(gcf);
    I=rgb2gray(I.cdata);
    close all

    img1 = double(I);
    img1 = img1/max(max(img1));
    img1 = 1-img1;
    [m,n] = size(img1);
    img1 = img1(round(m/2-msize):round(m/2+msize),round(n/2-msize):round(n/2+msize));
    img1 = imresize(img1,[nsize,nsize],'Antialiasing',true);
 
num = num1;
factor = randi([4 8]);
msize = nsize/factor;
vertices=zeros(num,2);
figure;
for i=1:num   
    for jj=1:num
        vertices(1,jj)=round(xsize*rand(1,1));
        vertices(2,jj)=round(xsize*rand(1,1));
    end                 
    vertices=vertices';
%         NumPoint=size(vertices,2)-1;%点的个数
    NumPoint = round(num*2/3);
    t=1/xsize:1/xsize:1;
    x=(1-t).^(NumPoint)*vertices(i,1);
    y=(1-t).^(NumPoint)*vertices(i,2);
    for j=1:NumPoint
        w=factorial(NumPoint)/(factorial(j)*factorial(NumPoint-j))*(1-t).^(NumPoint-j).*t.^(j);
        x=x+w*vertices(1,j+1);
        y=y+w*vertices(2,j+1);
    end
    set(gcf,'position',[0,0,512,512])
    plot(x,y,'k','LineWidth',0.5);
    axis equal;
    axis tight;
    axis off;
    hold on;
end
    I=getframe(gcf);
    I=rgb2gray(I.cdata);
    close all

    img2 = double(I);
    img2 = img2/max(max(img2));
    img2 = 1-img2;
    [m,n]=size(img2);
    img2 = img2(round(m/2-msize):round(m/2+msize),round(n/2-msize):round(n/2+msize));
    img2 = imresize(img2,[nsize,nsize],'Antialiasing',true);   

num = num1;     
factor = 6;
msize = nsize/factor;
vertices=zeros(num,2);
figure;
for i=1:num   
    for jj=1:num
        vertices(1,jj)=round(xsize*rand(1,1));
        vertices(2,jj)=round(xsize*rand(1,1));
    end                 
    vertices=vertices';
%         NumPoint=size(vertices,2)-1;%点的个数
    NumPoint = round(num*2/3);
    t=1/xsize:1/xsize:1;
    x=(1-t).^(NumPoint)*vertices(i,1);
    y=(1-t).^(NumPoint)*vertices(i,2);
    for j=1:NumPoint
        w=factorial(NumPoint)/(factorial(j)*factorial(NumPoint-j))*(1-t).^(NumPoint-j).*t.^(j);
        x=x+w*vertices(1,j+1);
        y=y+w*vertices(2,j+1);
    end
    set(gcf,'position',[0,0,512,512])
    plot(x,y,'k','LineWidth',0.5);
    axis equal;
    axis tight;
    axis off;
    hold on;
end
    I=getframe(gcf);
    I=rgb2gray(I.cdata);
    close all

    img3 = double(I);
    img3 = img3/max(max(img3));
    img3 = 1-img3;
    [m,n]=size(img3);
    img3 = img3(round(m/2-msize):round(m/2+msize),round(n/2-msize):round(n/2+msize));
    img3 = imresize(img3,[nsize,nsize],'Antialiasing',true);   
    
    img = img1 + img2 + img3;
   %% gaussian filter:
    hsize = 3;  sigma = 3;
    h = fspecial('gaussian',hsize,sigma); %
    img = imfilter(img,h)*2;
    
    img(img > 1) = 1;
    img(img < 0) = 0;
    img = XxNorm(img,0,100);
%     figure(3);imshow(img);
    %Save_path=set_path([folder_name,num2str(ii)]);
    %imwrite(img,fullfile(Save_path,'high_real.png'));
end