Hello = 'Data read from web url.'

url = 'http://openwsn.tongji.edu.cn:1316/ecgdata/id,ecg,date/id>0';
text = urlread(url);
fid = fopen('.temp.dat','wb');
fwrite(fid, text);
fclose(fid);

data = load('.temp.dat');
