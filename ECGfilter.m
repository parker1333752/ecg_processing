function [ ecg_out ] = ECGfilter( ecg ,fs)
%MYFILTER 此处显示有关此函数的摘要
%   此处显示详细说明

filters = designfilt('bandstopiir', 'FilterOrder', 2, ...
                     'PassbandFrequency1', 40, 'PassbandFrequency2', ...
                     60, 'PassbandRipple', 1, 'StopbandAttenuation', ...
                     30, 'SampleRate', fs, 'DesignMethod', 'ellip');
% fvtool(filters)
ecg_out = filter(filters, ecg);


% filters = designfilt('bandpassiir', 'FilterOrder', 4, ...
%                      'PassbandFrequency1', 0.5, 'PassbandFrequency2', ...
%                      130, 'PassbandRipple', 1, 'SampleRate', fs, ...
%                      'DesignMethod', 'cheby1');
% fvtool(filters)
ecg_out = filter(filters, ecg_out);

end







