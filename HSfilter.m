function [ hs_out ] = HSfilter( hs ,fs)
%HSfilter 

filters = designfilt('bandpassiir', 'FilterOrder', 6, ...
                     'PassbandFrequency1', 50, 'PassbandFrequency2', ...
                     150, 'PassbandRipple', 1, 'SampleRate', fs, ...
                     'DesignMethod', 'cheby1');
% fvtool(filters);
hs_out = filter(filters, hs);

end
