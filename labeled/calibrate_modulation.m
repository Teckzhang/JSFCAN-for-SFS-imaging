function [final_image] = calibrate_modulation(raw_image,pixel_size,width,position,vector)

%% function
factor = 0.001;
[y_size,x_size]=size(raw_image);
x = (-x_size/2+1:x_size/2)*pixel_size;
y = (-y_size/2+1:y_size/2)*pixel_size;
[X,Y]=meshgrid(x,y);
Y = Y-position(2);
X = X-position(1);
r=X+1i*Y;
    
k1 = pi/width*1i*conj(vector(1)/abs(vector(1)));
A1 = cos(real(k1*conj(r)));
k2 = pi/width*1i*conj(vector(2)/abs(vector(2)));
A2 = cos(real(k2*conj(r)));
% A1 = ones(y_size,x_size);
% A2 = ones(y_size,x_size);
Modu_Cali = 2*A1.*A2./(A1.^2+A2.^2+factor)+factor;
final_image = raw_image./Modu_Cali;
    