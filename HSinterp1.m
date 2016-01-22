function out = HSinterp1(data, date, fs0, fs1)
%MY_INTERP 此处显示有关此函数的摘要
%   此处显示详细说明

    %% first time interp: from (data,date,fs0) => (out0);
    d_date = 1/fs0*10000;
    dd=diff(date);
    date1 = [date(1)];
    for i = 1:size(dd,1)
        if dd/d_date > 1.5
            new_date = date(i) + d_date;
            date1 = [date1;new_date];
            while (date(i+1)-new_date)/d_date >1.5
                new_date = new_date + d_date;
                date1 = [date1;new_date];
            end
        end
        date1 = [date1;date(i+1)];
    end
    out0 = interp1(date, data, date1);
    
    %% second interp: from (out0,date1,fs0,fs1) => (out)
    len0 = size(date1,1);
    len1 = floor(fs1/fs0*len0);
    t0=linspace(0,1,len0);
    t1=linspace(0,1,len1);
    out=interp1(t0,out0,t1);
    
end
