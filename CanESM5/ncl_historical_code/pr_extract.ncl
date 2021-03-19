function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/CanESM5"
    prFiles = systemfunc("ls " + mainPath + "/historical/pr*.nc")

    pr_list1 = new((/1/),double)
    pr_list2 = new((/1/),double)
    pr_list3 = new((/1/),double)
    pr_list4 = new((/1/),double)
    pr_list5 = new((/1/),double)
    pr_list6 = new((/1/),double)
    pr_list7 = new((/1/),double)
    pr_list8 = new((/1/),double)

    do i = 0, 0
        f = addfile(prFiles(i), "r")
        prT42 := flt2dble(f->pr) ;; todouble()不能保存metadata，flt2dble()可以。
        print((/i/)) ;;signal

        prGrid1 := prT42(:,43,34)
        prGrid2 := prT42(:,40,35)
        prGrid3 := prT42(:,41,35)
        prGrid4 := prT42(:,42,35)
        prGrid5 := prT42(:,43,35)
        prGrid6 := prT42(:,39,36)
        prGrid7 := prT42(:,40,36) 
        prGrid8 := prT42(:,41,36)

        pr_list1 := array_append_record(pr_list1, prGrid1, 0)
        pr_list2 := array_append_record(pr_list2, prGrid2, 0)
        pr_list3 := array_append_record(pr_list3, prGrid3, 0)
        pr_list4 := array_append_record(pr_list4, prGrid4, 0)
        pr_list5 := array_append_record(pr_list5, prGrid5, 0)
        pr_list6 := array_append_record(pr_list6, prGrid6, 0)
        pr_list7 := array_append_record(pr_list7, prGrid7, 0)
        pr_list8 := array_append_record(pr_list8, prGrid8, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(pr_list1(44166:55115)) ;; 44166->1971:00:00, 55115->44166+10950-1->2000:12:31
    nor_par(1) = sqrt(variance(pr_list1(44166:55115))) ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    nor_par(2) = avg(pr_list2(44166:55115))
    nor_par(3) = sqrt(variance(pr_list2(44166:55115)))
    nor_par(4) = avg(pr_list3(44166:55115))
    nor_par(5) = sqrt(variance(pr_list3(44166:55115)))
    nor_par(6) = avg(pr_list4(44166:55115))
    nor_par(7) = sqrt(variance(pr_list4(44166:55115)))
    nor_par(8) = avg(pr_list5(44166:55115))
    nor_par(9) = sqrt(variance(pr_list5(44166:55115)))
    nor_par(10) = avg(pr_list6(44166:55115))
    nor_par(11) = sqrt(variance(pr_list6(44166:55115)))
    nor_par(12) = avg(pr_list7(44166:55115))
    nor_par(13) = sqrt(variance(pr_list7(44166:55115)))
    nor_par(14) = avg(pr_list8(44166:55115))
    nor_par(15) = sqrt(variance(pr_list8(44166:55115)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/CanESM5"
    prFiles = systemfunc("ls " + mainPath + "/historical/pr*.nc")

    pr_list1 = new((/1/), double, 0)
    pr_list2 = new((/1/), double, 0)
    pr_list3 = new((/1/), double, 0)
    pr_list4 = new((/1/), double, 0)
    pr_list5 = new((/1/), double, 0)
    pr_list6 = new((/1/), double, 0)
    pr_list7 = new((/1/), double, 0)
    pr_list8 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 0
        f = addfile(prFiles(i), "r")
        prT42 := flt2dble(f->pr) ;; todouble()不能保存metadata，flt2dble()可以。
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := prT42(:,43,34)
        prGrid1 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := prT42(:,40,35)
        prGrid2 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := prT42(:,41,35)
        prGrid3 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := prT42(:,42,35)
        prGrid4 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := prT42(:,43,35)
        prGrid5 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := prT42(:,39,36)
        prGrid6 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := prT42(:,40,36)
        prGrid7 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := prT42(:,41,36)
        prGrid8 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        pr_list1 := array_append_record(pr_list1, prGrid1, 0)
        pr_list2 := array_append_record(pr_list2, prGrid2, 0)
        pr_list3 := array_append_record(pr_list3, prGrid3, 0)
        pr_list4 := array_append_record(pr_list4, prGrid4, 0)
        pr_list5 := array_append_record(pr_list5, prGrid5, 0)
        pr_list6 := array_append_record(pr_list6, prGrid6, 0)
        pr_list7 := array_append_record(pr_list7, prGrid7, 0)
        pr_list8 := array_append_record(pr_list8, prGrid8, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/CanESM5/sdsm_historical_file/pr_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/canhprcpg1.dat"
    write_matrix(transpose(pr_list1(40516:56940)), "f9.3", opt1) ;; 40516->1961, 56940->40516+16425-1->2005
    opt2 = True ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    opt2@fout = outPath + "/canhprcpg2.dat"
    write_matrix(transpose(pr_list2(40516:56940)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/canhprcpg3.dat"
    write_matrix(transpose(pr_list3(40516:56940)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/canhprcpg4.dat"
    write_matrix(transpose(pr_list4(40516:56940)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/canhprcpg5.dat"
    write_matrix(transpose(pr_list5(40516:56940)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/canhprcpg6.dat"
    write_matrix(transpose(pr_list6(40516:56940)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/canhprcpg7.dat"
    write_matrix(transpose(pr_list7(40516:56940)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/canhprcpg8.dat"
    write_matrix(transpose(pr_list8(40516:56940)), "f9.3", opt8)

end