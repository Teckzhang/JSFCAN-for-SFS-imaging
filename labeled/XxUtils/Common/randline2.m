%%randomline
function [img] = randline(xsize,num)

if nargin == 1
  num = 15;
end

%folder_name='Line\';
    
    n = xsize;
    img=zeros(n,n);
    for j=1:num
        x1=floor(n*rand(1,1));
        y1=floor(n*rand(1,1));
        x2=floor(n*rand(1,1));
        y2=floor(n*rand(1,1));
        if x2~=x1
            a=((y2-y1)/(x2-x1));
            a=a/(abs(floor(a))+1);
            b=((x2*y1-y2*x1)/(x2-x1));
        else
            a=0;
            b=floor(y1);
        end
        num1=20*(rand(1,1));
        %% draw line
        nn = randi([10 12]);
        %if mod(j,5) == 0
         %  nn = randi([0 1]);
        %end
        
        %if mod(j,5) == 1
         %  nn = randi([0 1]);
        %end
        
        %if mod(j,5) == 2
         %  nn = randi([0 3]);
        %end
        
        %if mod(j,5) == 3
         %  nn = randi([0 3]);
        %end
        
         %if mod(j,5) == 3
          % nn = randi([0 8]);
        %end
      
        for i=1:n
            y=round(mod((a*i+b),n))+1;
            if j<=num1
                img(i,y:y+nn)=1;
            else
                img(y:y+nn,i)=1;
            end
        end
    end
    [x_size,y_size] = size(img);
    if x_size >n||y_size >n
       img = img(1:n,1:n); 
    end
%      img = imresize(img,[160,160],'Antialiasing',true);
    img = imresize(img,[xsize,xsize],'Antialiasing',true);
    % gaussian filter:
    hsize = 3;
    sigma = 3;
    h = fspecial('gaussian',hsize,sigma); %
    img = imfilter(img,h);
    img = img/max(max(img))*1;  % 亮度提高
    
    img(img > 1) = 1;
    img(img < 0) = 0;
    img = XxNorm(img,0,100);
    %imshow(img)
   % Save_path=set_path([folder_name,num2str(ii)]);
    %imwrite(img*2,fullfile(Save_path,'high_real.png'));
    %close all
end