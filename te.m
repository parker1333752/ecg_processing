% Configuration.
data_folder = 'tmp1';
file_extension = 'adc.dat';

% Find newest data file.
file_name = findNewestFile(data_folder, file_extension)
% file_name = '1453530112293.adc.dat';
file_name = strjoin({data_folder,file_name},'\');

% Read original data.
[ecg,hs,accx,accy,accz,omegax,omegay,...
    omegaz,datex,date0,len,err] = filedataread(file_name);
clear file_name
if all(strjoin({err,'a'},'')=='a')
    clear err
else
    % Data error occur and then clear all data.
    clear ecg hs accx accy accz omegax omegay 
    clear omegaz datex len
end

% Calculate frequency of sampling.
fs = 390;

% Heart sound preprocess.
hs_f = HSfilter(hs,fs);
hs_o = HSinterp1(hs_f,datex,fs,4410);
o = audioplayer(hs_o*500,4410);

% Ecg signal preprocess.
ecg_f = ECGfilter(ecg,fs);
% powerFreq(ecg_f,fs);
