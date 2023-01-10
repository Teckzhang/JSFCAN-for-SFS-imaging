function [phase]=imphase(object)
 num = size(object);
num = num(1);
phase = object;
phase = 1*pi*imresize(phase,[num num])./max(max(phase)); %max(max())是求整个矩阵的最大值 imresize调整图像尺寸为[num,num]，默认为最近邻插值
end