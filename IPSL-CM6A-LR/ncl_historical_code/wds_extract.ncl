begin
    mainPath = "/home/taka/Passport/CMIP6/IPSL-CM6A-LR"
    uasFiles = systemfunc("ls " + mainPath + "/historical/uas_*.nc")
    vasFiles = systemfunc("ls " + mainPath + "/historical/vas_*.nc")

    wds_list1 = new((/1/), double, 0)
    wds_list2 = new((/1/), double, 0)
    wds_list3 = new((/1/), double, 0)
    wds_list4 = new((/1/), double, 0)
    wds_list5 = new((/1/), double, 0)
    wds_list6 = new((/1/), double, 0)
    wds_list7 = new((/1/), double, 0)
    wds_list8 = new((/1/), double, 0)

    do i = 0, dimsizes(uasFiles)-1
        f1 = addfile(uasFiles(i), "r")
        f2 = addfile(vasFiles(i), "r")
        uasT42 := flt2dble(f1->uas) ;; todouble()不能保存metadata，flt2dble()可以。
        vasT42 := flt2dble(f2->vas)
        uasT42 := f2gsh_Wrap(uasT42, (/64, 128/), 0)
        vasT42 := f2gsh_Wrap(vasT42, (/64, 128/), 0)
        wdsT42 := wind_direction(uasT42, vasT42, 0)
        print((/i/)) ;;signal

        wdsGrid1 := wdsT42(:,43,34)
        wdsGrid2 := wdsT42(:,40,35)
        wdsGrid3 := wdsT42(:,41,35)
        wdsGrid4 := wdsT42(:,42,35)
        wdsGrid5 := wdsT42(:,43,35)
        wdsGrid6 := wdsT42(:,39,36)
        wdsGrid7 := wdsT42(:,40,36)
        wdsGrid8 := wdsT42(:,41,36)

        wds_list1 := array_append_record(wds_list1, wdsGrid1, 0)
        wds_list2 := array_append_record(wds_list2, wdsGrid2, 0)
        wds_list3 := array_append_record(wds_list3, wdsGrid3, 0)
        wds_list4 := array_append_record(wds_list4, wdsGrid4, 0)
        wds_list5 := array_append_record(wds_list5, wdsGrid5, 0)
        wds_list6 := array_append_record(wds_list6, wdsGrid6, 0)
        wds_list7 := array_append_record(wds_list7, wdsGrid7, 0)
        wds_list8 := array_append_record(wds_list8, wdsGrid8, 0)
    end do

    ;; 1850:1:1-1960:12:31 共111*365+27=40542天。加 1 成为序列开头
    ;; 1961:1:1-2005:12:31 共16436天，40543+16436-1=56978
    outPath = "/home/taka/Passport/Climate_data_code/IPSL-CM6A-LR/sdsm_historical_file/wds_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ipshp_thg1.dat"
    write_matrix(transpose(wds_list1(40543:56978)), "f9.3", opt1)
    opt2 = True ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    opt2@fout = outPath + "/ipshp_thg2.dat"
    write_matrix(transpose(wds_list2(40543:56978)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ipshp_thg3.dat"
    write_matrix(transpose(wds_list3(40543:56978)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ipshp_thg4.dat"
    write_matrix(transpose(wds_list4(40543:56978)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ipshp_thg5.dat"
    write_matrix(transpose(wds_list5(40543:56978)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ipshp_thg6.dat"
    write_matrix(transpose(wds_list6(40543:56978)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ipshp_thg7.dat"
    write_matrix(transpose(wds_list7(40543:56978)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ipshp_thg8.dat"
    write_matrix(transpose(wds_list8(40543:56978)), "f9.3", opt8)

end