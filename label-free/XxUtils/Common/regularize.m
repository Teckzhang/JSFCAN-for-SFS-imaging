function [object]=regularize(object)
 num = size(object);
num = num(1);
I_max=255;
I_min=1;
for i=1:num
    for j = 1:num 
    if object(i,j)>I_max
        object(i,j) = I_max;
    elseif object(i,j)< I_min
            object(i,j)= I_min;
    else
        object(i,j) = object(i,j);
    end
    end
end
end