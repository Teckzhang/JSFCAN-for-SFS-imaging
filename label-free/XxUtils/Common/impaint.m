function [spectrum]=impaint(a,lamda,k00,ke,phi,illumSteps)
cutK = (2*pi/lamda*a);  % cutK=3k00
ang = 0 :pi/100: 2*pi; %角度范围
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
CircleY = (k00+cutK) * sin(ang);%从这里可以看出来这里先画的是每圈能取到的最高频率，也就是每圈的通频带半径分别是cutK和2*k00+cutK
plot(CircleX,CircleY,'g');
%theta = zeros(length(ke),max(illumSteps));

for ii = 1:length(ke)
    theta = zeros(length(ke(ii)),illumSteps(ii));
    theta_h = phi(ii) : 2*pi/illumSteps(ii) : 2*pi.*(illumSteps(ii)-1)/illumSteps(ii)+phi(ii); %(第一圈是0 120 240 第二圈就从60开始为60 180 300)
    theta = theta_h;
    for j=1:length(theta)
        kx = ke(ii) * cos(theta(j));
        ky = ke(ii) * sin(theta(j));%各圆的圆心所在位置
        CircleX = kx + k00*cos(ang);
        CircleY = ky + k00*sin(ang);
        plot(CircleX,CircleY,'b');  
        hold on
    end
end

%for i=1:length(ke)
    %for j=1:length(theta(i,:))
        %kx = ke(i) * cos(theta(i,j));
        %ky = ke(i) * sin(theta(i,j));%各圆的圆心所在位置
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