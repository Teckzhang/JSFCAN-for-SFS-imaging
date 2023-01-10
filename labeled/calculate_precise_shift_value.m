function precise_shift_value_low = calculate_precise_shift_value(shiftvalue,reference,final_image_frequency)
%% After finding the nearest integer from the frequency shift, the decimal near the integer satisfying the maximum value is found, that is, the more accurate maximum coordinate to use as the final frequency shift.
[y_size,x_size] = size(reference);
search_angle_num=15;
search_range = 0.8;
myangle=0:2*pi/search_angle_num:(2*pi-2*pi/search_angle_num);
sin_angle=sin(myangle);
cos_angle=cos(myangle);
center_x = shiftvalue(1);
center_y = shiftvalue(2);
temp_value=zeros(1,search_angle_num+1);
temp_phase=zeros(1,search_angle_num+1);
%% Spectrum separation
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
%% To find the exact frequency shift
mytemp = sum(sum(conj(reference).*circshift(rep_temp,[center_x,center_y])));%After the isolated R2 is moved to the position of known rough frequency shift, the correlation calculation is performed with the reference spectrum.
% test_ini_phase = angle(mytemp);
temp_value_max = mytemp;
temp_phase(1,search_angle_num+1)=angle(mytemp);
% figure;
% imagesc(abs(exact_shift(rep_temp,[center_x,center_y],1)));

temp_search = search_range;

    while temp_search>0.02
        for kk=1:search_angle_num
            temp=exact_shift(rep_temp,[center_x+cos_angle(kk)*temp_search,...
                center_y+sin_angle(kk)*temp_search],1);%
            mytemp=sum(sum(conj(reference).*temp));%
            temp_phase(1,kk)=angle(mytemp);
            temp_value(1,kk)=mytemp;
        end
        temp_value(1,kk+1)=temp_value_max;
        temp_max=max(abs(temp_value));
        [xx,yy]=find(abs(temp_value)==temp_max);
        my_num=max(xx,yy);
        temp_value_max=temp_value(my_num);
        if my_num<search_angle_num+0.5
            center_x = center_x+cos_angle(my_num)*temp_search;
            center_y = center_y+sin_angle(my_num)*temp_search;
%             test_ini_phase = temp_phase(my_num);
            temp_phase(1,kk+1) = temp_phase(my_num);
        end
        temp_search=temp_search*0.5;
    end
 precise_shift_value_low = [center_x,center_y];
