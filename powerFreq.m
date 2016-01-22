function [ Y,t ] = powerFreq( data,fs )
%PLOTFREQ 此处显示有关此函数的摘要
%   此处显示详细说明
len = size(data,1) * size(data,2);
Y = abs(fft(xcorr(data,'unbias'),len));
t = linspace(0,fs,len);
figure(333)
plot(t,Y);
end

