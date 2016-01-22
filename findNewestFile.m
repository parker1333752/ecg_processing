function name = findNewestFile(folder, extension)
    list_ = dir(folder);
    datex = datetime(0,0,0,0,0,0);
    len_min = size(extension,2);
    for i = 1:size(list_)
        cur_name = list_(i).name;
        len_cur = size(cur_name,2);
        if len_cur > len_min 
            if all(cur_name(len_cur-len_min+1:len_cur)==extension)
                if datex < datetime(list_(i).date)
                    datex = datetime(list_(i).date);
                    name = cur_name;
                end
            end
        end
    end     
end