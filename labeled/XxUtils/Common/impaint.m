function [spectrum]=impaint(a,lamda,k00,ke,phi,illumSteps)
cutK = (2*pi/lamda*a);  % cutK=3k00
ang = 0 :pi/100: 2*pi; %�Ƕȷ�Χ
CircleX = k00 * cos(ang);
CircleY = k00 * sin(ang);
figure(50);
plot(CircleX,CircleY,'r');
axis on
axis square;
hold on
%CircleX = cutK * cos(ang);
%CircleY = cutK * sin(ang);
%plot(CircleX,CircleY,'g');
illumSteps;
CircleX = (k00+cutK) * cos(ang);
CircleY = (k00+cutK) * sin(ang);%��������Կ����������Ȼ�����ÿȦ��ȡ�������Ƶ�ʣ�Ҳ����ÿȦ��ͨƵ���뾶�ֱ���cutK��2*k00+cutK
plot(CircleX,CircleY,'g');
%theta = zeros(length(ke),max(illumSteps));

for ii = 1:length(ke)
    theta = zeros(length(ke(ii)),illumSteps(ii));
    theta_h = phi(ii) : 2*pi/illumSteps(ii) : 2*pi.*(illumSteps(ii)-1)/illumSteps(ii)+phi(ii); %(��һȦ��0 120 240 �ڶ�Ȧ�ʹ�60��ʼΪ60 180 300)
    theta = theta_h;
    for j=1:length(theta)
        kx = ke(ii) * cos(theta(j));
        ky = ke(ii) * sin(theta(j));%��Բ��Բ������λ��
        CircleX = kx + k00*cos(ang);
        CircleY = ky + k00*sin(ang);
        plot(CircleX,CircleY,'b');  
        hold on
    end
end

%for i=1:length(ke)
    %for j=1:length(theta(i,:))
        %kx = ke(i) * cos(theta(i,j));
        %ky = ke(i) * sin(theta(i,j));%��Բ��Բ������λ��
        %CircleX = kx + k00*cos(ang);
        %CircleY = ky + k00*sin(ang);
        %plot(CircleX,CircleY,'b');  
        %hold on
    %end
%end
%axis([-1.8*cutK,1.8*cutK,-1.8*cutK,1.8*cutK]);
axis off;
hold off;
f=getframe(gcf);
spectrum=f.cdata;
end