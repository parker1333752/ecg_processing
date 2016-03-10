function [ hs_out ] = HSfilter( hs ,fs)
%HSfilter 

filters = designfilt('bandpassiir', 'FilterOrder', 6, ...
                     'PassbandFrequency1', 30, 'PassbandFrequency2', ...
                     150, 'PassbandRipple', 1, 'SampleRate', fs, ...
                     'DesignMethod', 'cheby1');
% fvtool(filters);
hs = filter(filters, hs);

filters2 = design(fdesign.notch('N,F0,Q,Ap',2,50,10,1,390));
hs = filter(filters2, hs);

hs_out = hs;
end
