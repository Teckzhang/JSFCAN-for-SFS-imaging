function [shiftvalue] = calculate_shift_value(reference,final_image_frequency,fmask)
[y_size,x_size] = size(reference);
y_origin = ceil((y_size+1)/2);
x_origin = ceil((x_size+1)/2);

matrix = [1,1/2*exp(-1i*(pi*0)),1/2*exp(1i*(pi*0));...
          1,1/2*exp(-1i*(pi*2/3)),1/2*exp(1i*(pi*2/3));...
          1,1/2*exp(-1i*(pi*4/3)),1/2*exp(1i*(pi*4/3))];
    
inverse_matrix = inv(matrix);
re0_temp=zeros(y_size,x_size);
rep_temp=zeros(y_size,x_size);
rem_temp=zeros(y_size,x_size);

  
for jj = 1:3 
    
    re0_temp = inverse_matrix(1,jj)*final_image_frequency(:,:,jj)+re0_temp;
    rep_temp = inverse_matrix(2,jj)*final_image_frequency(:,:,jj)+rep_temp;
    rem_temp = inverse_matrix(3,jj)*final_image_frequency(:,:,jj)+rem_temp;
end

low_temp = fftshift(fft2(fftshift(reference)));
% high_temp = fftshift(fft2(fftshift(high_image_frequency_positive)));
high_temp = fftshift(fft2(fftshift(rep_temp)));
cor_temp = low_temp.*conj(high_temp);
cor_result = conj(ifftshift(ifft2(ifftshift(cor_temp))));
% cor_result = cor_result/max(max(abs(cor_result)));
% figure;
% subplot(1,2,1);imagesc(abs(cor_result));
% subplot(1,2,2);imagesc(abs(cor_result).*fmask);
[p,q] = find(abs(cor_result).*fmask==max(max(abs(cor_result).*fmask)));
% angle(cor_result(p,q))
shiftvalue = [p,q]-[y_origin,x_origin];