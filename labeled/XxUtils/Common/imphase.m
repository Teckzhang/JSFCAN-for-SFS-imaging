function [phase]=imphase(object)
 num = size(object);
num = num(1);
phase = object;
phase = 1*pi*imresize(phase,[num num])./max(max(phase)); %max(max())����������������ֵ imresize����ͼ��ߴ�Ϊ[num,num]��Ĭ��Ϊ����ڲ�ֵ
end