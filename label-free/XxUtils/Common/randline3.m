%%randomline
function [img] = randline3(xsize,num)

if nargin == 1
  num = 5;
end

%folder_name='Line\';
    n = xsize;
    img=zeros(n,n);
    dot=zeros(num,2)';
    for jj=1:num
        dot(1,jj)=round(xsize*rand(1,1)); %x
    end      
     dot(1,:)=sort(dot(1,:));
    for jj=1:num
        dot(2,jj)=round(xsize*rand(1,1)); %y
    end    
    %dot(:,end+1)=dot(:,1);
    x=dot(1,:)
    y=dot(2,:)
    figure;
    hold on;
    %set(gcf,'position',[0,0,2008,2008])
    plot(x,y,'k',"Linewidth",3);
    mm = randi([100 120]);
    newdot=polybuffer(dot','Lines',10)
   
    plot(dot,'k',"Linewidth",3);
    %plot(x-mm,y-mm,'k');
    axis equal;
    axis tight;
    axis off;
    hold off;
    
    I=getframe(gcf);
    I=rgb2gray(I.cdata);
    close all

    img1 = double(I);
    img1 = img1/max(max(img1));
    img1 = 1-img1;
    [m,n] = size(img1);
    %img1 = img1(round(m/2-msize):round(m/2+msize),round(n/2-msize):round(n/2+msize));
    img1 = imresize(img1,[n,n],'Antialiasing',true);
 
    img = img1;
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