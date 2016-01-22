function [ Y,t ] = powerFreq( data,fs )
%PLOTFREQ �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
len = size(data,1) * size(data,2);
Y = abs(fft(xcorr(data,'unbias'),len));
t = linspace(0,fs,len);
figure(333)
plot(t,Y);
end

