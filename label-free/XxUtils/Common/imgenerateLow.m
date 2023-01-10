%function [imWhiteLowRes,Imwhite]=imgenerateLow(m,n,m1,n1,CTF0,objectFT)
function imWhiteLowRes=imgenerateLow(m,n,m1,n1,CTF0,objectFT)
kxc = round((n+1)/2);
kyc = round((m+1)/2);
kyl = round(kyc-(m1-1)/2); kyh = round(kyc+(m1-1)/2);
kxl = round(kxc-(n1-1)/2); kxh = round(kxc+(n1-1)/2);
imWhiteLowFT = objectFT(kyl:kyh,kxl:kxh).*CTF0; %？为什么要有这个系数
imWhiteLowRes = abs(ifft2(ifftshift(imWhiteLowFT))).^2;
%CTFF0 = CTF0;
%CTFF0 = ~CTFF0;
%Imwhite = objectFT;
%Imwhite(kyl:kyh,kxl:kxh) = Imwhite(kyl:kyh,kxl:kxh).*CTFF0;
end