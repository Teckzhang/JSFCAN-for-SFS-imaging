function [final_image] = calibrate_waveguide_SIM_image(raw_image,pixel_size,width,position,vector)
%% function
factor = 0.001;

[y_size,x_size,phase_number]=size(raw_image);
x = (-x_size/2+1:x_size/2)*pixel_size;
y = (-y_size/2+1:y_size/2)*pixel_size;
[X,Y]=meshgrid(x,y);
Y = Y-position(2);
X = X-position(1);
r=X+1i*Y;

final_image = zeros(y_size,x_size,phase_number);%Used to store corrected images
    
k1 = pi/width*1i*conj(vector(1)/abs(vector(1)));
k2 = pi/width*1i*conj(vector(2)/abs(vector(2)));
A2 = cos(real(k2*conj(r)));
% A1 = ones(y_size,x_size);
% A2 = ones(y_size,x_size);
Calibration = (A1.^2+A2.^2)/2+factor;%The average illumination intensity at each position after the two modes interfere
for jj = 1:phase_number
    final_image(:,:,jj) = raw_image(:,:,jj)./Calibration;
end
