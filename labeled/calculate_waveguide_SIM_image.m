function [final_image] = calculate_waveguide_SIM_image(Object,OTF,pixel_size,width,position,vector,phase)

%% function
[y_size,x_size]=size(Object);
x = (-x_size/2+1:x_size/2)*pixel_size;
y = (-y_size/2+1:y_size/2)*pixel_size;
[X,Y]=meshgrid(x,y);
Y = Y-position(2);
X = X-position(1);
r=X+1i*Y

[angle_number,~] = size(vector);
final_image = zeros(y_size,x_size,length(phase),angle_number);
% for ii=1:angle_number
for ii = 1
    
    k1 = pi/width*1i*conj(vector(ii,1)/abs(vector(ii,1)))
    A1 = cos(real(k1*conj(r)));
    k2 = pi/width*1i*conj(vector(ii,2)/abs(vector(ii,2)));
    A2 = cos(real(k2*conj(r)));
   
%     A1 = ones(y_size,x_size);
%     A2 = ones(y_size,x_size);
    for jj = 1:length(phase)
        E1 = A1.*exp(1i*(real(vector(ii,1)*conj(r))+phase(jj)));
    
        E2 = A2.*exp(1i*(real(vector(ii,2)*conj(r))));
        E_sum = (E1+E2).*conj(E1+E2)/2;
%         k_illumination = (vector(ii,1)-vector(ii,2))/2;
%         illumination_pattern = (cos(real(k_illumination*conj(r))+phase(jj)/2)).^2;
        object_SIM=E_sum.*Object;
        %figure; imshow(object_SIM/max(max(object_SIM)))
        object_frequency_SIM=fftshift(fft2(fftshift(object_SIM)));
        image_frequency_SIM=object_frequency_SIM.*OTF;
        final_image(:,:,jj,ii) = ifftshift(ifft2(ifftshift(image_frequency_SIM)));
%         figure(1);subplot(1,length(phase),jj);
%         imagesc(x(x_size*2/5:x_size*3/5)/1000,y(y_size*2/5:y_size*3/5)/1000,E_sum(y_size*2/5:y_size*3/5,x_size*2/5:x_size*3/5));
%         
%         figure(2);subplot(1,length(phase),jj);
%         imagesc(x(x_size*2/5:x_size*3/5)/1000,y(y_size*2/5:y_size*3/5)/1000,illumination_pattern(y_size*2/5:y_size*3/5,x_size*2/5:x_size*3/5));
%         figure(3);subplot(1,length(phase),jj);
%         imagesc(x(x_size*2/5:x_size*3/5)/1000,y(y_size*2/5:y_size*3/5)/1000,final_image(y_size*2/5:y_size*3/5,x_size*2/5:x_size*3/5,ii,jj));
    end
end
% figure;
% imagesc(x(x_size*2/5:x_size*3/5)/1000,y(y_size*2/5:y_size*3/5)/1000,Object(y_size*2/5:y_size*3/5,x_size*2/5:x_size*3/5));
