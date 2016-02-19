function [ecg,hs,accx,accy,accz,omegax,omegay,omegaz,date,date0,len,err] = filedataread(fname)
    f_adcname = fname;
    err = '';
    
    len_data = 22;
    record_count = flength(f_adcname) / (len_data);
    fid = fopen(f_adcname);
    if fid >= 3
        ecg=fread(fid,[record_count,1],'int32',len_data-4);
        fseek(fid, 4, -1);hs=fread(fid,[record_count,1],'int32',len_data-4);
        % acc = value / 32768 * (8 or 16) g;
        % omega = value / 32768 * ...(250 or 2000) du/s;
        fseek(fid, 8, -1);accx = fread(fid, [record_count, 1], 'int16', len_data - 2); fseek(fid, 2 + 8, -1);
        accy = fread(fid, [record_count, 1], 'int16', len_data - 2); fseek(fid, 4 + 8, -1);
        accz = fread(fid, [record_count, 1], 'int16', len_data - 2); fseek(fid, 6 + 8, -1);
        omegax = fread(fid, [record_count, 1], 'int16', len_data - 2); fseek(fid, 8 + 8, -1);
        omegay = fread(fid, [record_count, 1], 'int16', len_data - 2); fseek(fid, 10 + 8, -1);
        omegaz = fread(fid, [record_count, 1], 'int16', len_data - 2); fseek(fid, 12 + 8, -1);
        date = fread(fid, [record_count, 1], 'int16', len_data - 2); % 100us. value = 0~32767;
        fclose(fid);
        
        date0 = date;
        overflow=0;
        for i=2:record_count
            date(i)=date(i)+overflow;
            if date(i)<date(i-1)
                date(i)=date(i)+32768;
                overflow=overflow+32768;
            end
        end
        hs = hs*2.8/hex2dec('10000000');
        ecg = ecg*1.2/hex2dec('10000000');
        len = size(date,1);
    else
        err = [err,'erro: adc file not found.\n'];
        ecg=[];
        hs=[];
        accx=[];
        accy=[];
        accz=[];
        omegax=[];
        omegay=[];
        omegaz=[];
        date=[];
        date0=[];
        len = 0;
    end
end

function length = flength(filename)
    fid = fopen(filename, 'rb');
    if fid == -1
        length = 0;
        return
    end
    fseek(fid,0,1);
    length = ftell(fid);
    fclose(fid);
end