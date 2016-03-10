clear;

% Coppnfiguration.
data_folder = 'tmp2';
file_extension = 'adc.dat';

% Find newest data file.
% [file_name,datex] = findNewestFile(data_folder, file_extension)
file_name = 'lower_lab_stand.dat';
file_name = strjoin({data_folder,file_name},'\');

% Read original data.
[ecg,hs,accx,accy,accz,omegax,omegay,...
    omegaz,datex,date0,len,error] = filedataread(file_name);
if all(strjoin({error,'a'},'')=='a')
    clear error
else
    % Data error occur and then clear all data.
    clear ecg hs accx accy accz omegax omegay 
    clear omegaz datex len date0 file_extension data_folder
    return
end
acc_gain = 8;
if acc_gain == 8
    omega_gain = 250;
else
    omega_gain = 2000;
end
accx = accx/32768*acc_gain;
accy = accy/32768*acc_gain;
accz = accz/32768*acc_gain;
omegax = omegax/32768*omega_gain;
omegay = omegay/32768*omega_gain;
omegaz = omegaz/32768*omega_gain;
clear file_name

% % Calculate frequency of sampling.
fs = 390;
% 
% % Heart sound preprocess.
hs_f = HSfilter(hs,fs);
% hs_o = HSinterp1(hs_f,datex,fs,4410);
% o = audioplayer(hs_o*500,4410);
% 
% % Ecg signal preprocess.
ecg_f = ECGfilter(ecg,fs);
% plot(1:len,[ecg_f+0.5,hs_f-0.5])
% % powerFreq(ecg_f,fs);

%{
%  The break of date value is caused by data losing, so it can't be ignore.
% datex interval test.t
dd=diff(datex);
datex(2:len) = zeros(len-1,1);
for i=1:len-1
    if dd(i)>10000
        datex(i+1) =  datex(i) + 26;
    else
        datex(i+1) =  datex(i) + dd(i);
    end
end
%}

% plot(1:len-1,dd);
% figure(1);plot(1:len,hs_f);title('heart sound');
% figure(2);plot(1:len,ecg_f);title('ecg');

% findBestAccDirection();