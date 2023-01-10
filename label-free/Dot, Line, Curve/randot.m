function [img] = randot(n, num, min_size,max_size)
% num <= x_size
if nargin == 2
  min_size = 50;
  max_size = 100;
end

if nargin == 1
  num = 30;
end
    
    x_size = randi([min_size max_size]);
    if num>x_size
       num = x_size;
    end
    img1=zeros(x_size,x_size);
    x=floor(x_size*rand(1,x_size));
    y=floor(x_size*rand(1,x_size));
    for i=1:num/2
        img1(x(1,i)+1,y(1,i)+1)=1;
    end
    img1 = imresize(img1,[n,n]);
    
    x_size = randi([min_size*1.5 max_size]);
    if num>x_size
       num = x_size;
    end
    img2=zeros(x_size,x_size);
    x=floor(x_size*rand(1,x_size));
    y=floor(x_size*rand(1,x_size));
    for i=1:num
        img2(x(1,i)+1,y(1,i)+1)=1;
    end
    img2 = imresize(img2,[n,n]);
    
    x_size = randi([min_size round(max_size/1.5)]);
      if num>x_size
       num = x_size;
    end
    img3=zeros(x_size,x_size);
    x=floor(x_size*rand(1,x_size));
    y=floor(x_size*rand(1,x_size));
    for i=1:num/2
        img3(x(1,i)+1,y(1,i)+1)=1;
    end
    img3 = imresize(img3,[n,n]);
     
    img = img1 + img2 + img3;
    img(img > 1) = 1;
    img(img < 0) = 0;
    img = XxNorm(img,0,100);
    
    %Save_path=set_path([folder_name,num2str(j)]);
    %imwrite(img,fullfile(Save_path,'high_real.png'));
end