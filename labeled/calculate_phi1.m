function [phi1,shift_phase] = calculate_phi1(precise_shift_value,reference,low_image_frequency,final_image_frequency,fmask)
%% calculate phi1
[y_size,x_size] = size(reference);
y_origin = ceil((y_size+1)/2);
x_origin = ceil((x_size+1)/2);
equation_number = 4;%
phi1 = zeros(equation_number,2);
sep_set = [0,2/3*pi,4/3*pi;
           0,1/3*pi,2/3*pi;
           0,4/7*pi,10/7*pi;
           0,4/5*pi,8/5*pi];

a = [0.1,0.2,0.15,-0.2];
b = [0.1,-0.1,-0.15,0.2];
c = [-0.1,-0.2,0.3,0.3];

% a = zeros(4,1);
% b = zeros(4,1);
% c = zeros(4,1);


matrix = zeros(3,3,equation_number);
inverse_matrix = zeros(3,3,equation_number);
for ii = 1:equation_number %
    matrix(:,:,ii) = [a(ii)+1,0.5*exp(-1i*(sep_set(ii,1))),0.5*exp(1i*(sep_set(ii,1)));
                      b(ii)+1,0.5*exp(-1i*(sep_set(ii,2))),0.5*exp(1i*(sep_set(ii,2)));
                      c(ii)+1,0.5*exp(-1i*(sep_set(ii,3))),0.5*exp(1i*(sep_set(ii,3)))];
    inverse_matrix(:,:,ii) = inv(matrix(:,:,ii));
end
clear sep_set;
clear a b c;

sep_f = zeros(y_size,x_size,equation_number,3);
sep_f_update = zeros(y_size,x_size,equation_number,3);
% phase = zeros(equation_number,1);

for kk=1:equation_number
% for kk=4   
    re0_temp=zeros(y_size,x_size);
    rep_temp=zeros(y_size,x_size);
    rem_temp=zeros(y_size,x_size);
    
    for jj = 1:3
        re0_temp = inverse_matrix(1,jj,kk)*final_image_frequency(:,:,jj)+re0_temp;
        rep_temp = inverse_matrix(2,jj,kk)*final_image_frequency(:,:,jj)+rep_temp;
        rem_temp = inverse_matrix(3,jj,kk)*final_image_frequency(:,:,jj)+rem_temp;
    end
    
    sep_f(:,:,kk,1) = re0_temp;
    sep_f(:,:,kk,2) = rep_temp;
    sep_f(:,:,kk,3) = rem_temp;% ep f records the separated spectrum R1,R2,R3.
    
    factor = sum(inverse_matrix(2,:,kk));
    sep_f_update(:,:,kk,2) = sep_f(:,:,kk,2)-factor*low_image_frequency;% sep_f(:,:,kk,2) subtracts the fundamental frequency component, and the result contains only the high frequencies
    low_temp = fftshift(fft2(fftshift(reference)));
    % high_temp = fftshift(fft2(fftshift(high_image_frequency_positive)));
    high_temp = fftshift(fft2(fftshift(sep_f_update(:,:,kk,2))));
    cor_temp = low_temp.*conj(high_temp);
 
    cor_result = conj(ifftshift(ifft2(ifftshift(cor_temp)))).*fmask;
    cor_result = cor_result/max(max(abs(cor_result)));
%     figure(3);
%     imagesc(abs(cor_result));
    
    [p,q] = find(abs(cor_result)==max(max(abs(cor_result))));
%     phi1_low(kk,1) = cor_result(p,q);
 
    if sqrt((p-y_origin-precise_shift_value(1))^2 + (q-x_origin-precise_shift_value(2))^2)<2
        phi1(kk,2)=1;
    else
        phi1(kk,2)=2;
    end
    cor_result2 = sum(sum(conj(reference).*exact_shift(sep_f_update(:,:,kk,2),precise_shift_value,1)));%根据已经求得的频移量（即极大值坐标），直接得到极大值。
    phi1(kk,1) = cor_result2;
%     phi1(kk,1) = cor_result(p,q);
end

 inv_matrix_row = zeros(equation_number,3);
 est_phi1 = zeros (1,equation_number);
 for ii=1:equation_number
     inv_matrix_row(ii,:) = inverse_matrix(2,:,ii);
     est_phi1(ii) = phi1(ii,1);
 end
 
 [~,final_ans]=solve_trigonometric_linear_equation_var3(est_phi1,inv_matrix_row);%Input the information of the maximum value and the multiplied inverse matrix into the function of solving the equation to find the corresponding phase of the three SIM photos.
 shift_phase = final_ans;