function [ Y,t ] = powerFreq( data,fs )
%PLOTFREQ 此处显示有关此函数的摘要
%   此处显示详细说明
len = size(data,1) * size(data,2);
Y = abs(fft(xcorr(data,'unbias'),len));
t = linspace(0,fs,len);
x = 50;
if fs>50
    x = ceil(x/fs*(len-1));
else
    x = len;
end
x = 1:x;
t = t(x);
Y = Y(x);
end
