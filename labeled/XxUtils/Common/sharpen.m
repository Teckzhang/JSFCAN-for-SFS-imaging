function [fsha,fedg]=sharpen(f,Operator)
 
%根据模板进行锐化
%适用于真彩色图像与灰度图像
%f为原图像，Operator为锐化模板
%输出的fsha为锐化后的图像，fedg为已取反的加重的边缘
%double型
 
[m,n,h]=size(f);
fsha=f;
 
for k=1:h
    for i=2:m-1
        for j=2:n-1
            fsha(i,j,k)=sum(sum(f(i-1:i+1,j-1:j+1,k).*Operator)); %根据模板进行锐化处理
        end
    end
end
if sum(Operator(:))>0
    fedg=f-fsha+1; %取反加重的边缘
else
    fedg=1-fsha; %取反未加重的边缘
    fsha=f+fsha; %此时，锐化图像=原图像+边缘
end