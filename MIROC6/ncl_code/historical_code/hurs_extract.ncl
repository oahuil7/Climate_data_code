function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    hursFiles = systemfunc("ls " + mainPath + "/historical/hurs*.nc")
    hursFiles := hursFiles(1:)

    hurs_list1 = new((/1/),double)
    hurs_list2 = new((/1/),double)
    hurs_list3 = new((/1/),double)
    hurs_list4 = new((/1/),double)
    hurs_list5 = new((/1/),double)
    hurs_list6 = new((/1/),double)
    hurs_list7 = new((/1/),double)
    hurs_list8 = new((/1/),double)

    do i = 0, 3
        f = addfile(hursFiles(i), "r")
        hurs := flt2dble(f->hurs) ;; todouble()不能保存metadata，flt2dble()可以。
        hursT42 := f2gsh_Wrap(hurs, (/64, 128/), 0)
        print((/i/)) ;;signal

        hursGrid1 := hursT42(:,43,34)
        hursGrid2 := hursT42(:,40,35)
        hursGrid3 := hursT42(:,41,35)
        hursGrid4 := hursT42(:,42,35)
        hursGrid5 := hursT42(:,43,35)
        hursGrid6 := hursT42(:,39,36)
        hursGrid7 := hursT42(:,40,36) 
        hursGrid8 := hursT42(:,41,36)

        hurs_list1 := array_append_record(hurs_list1, hursGrid1, 0)
        hurs_list2 := array_append_record(hurs_list2, hursGrid2, 0)
        hurs_list3 := array_append_record(hurs_list3, hursGrid3, 0)
        hurs_list4 := array_append_record(hurs_list4, hursGrid4, 0)
        hurs_list5 := array_append_record(hurs_list5, hursGrid5, 0)
        hurs_list6 := array_append_record(hurs_list6, hursGrid6, 0)
        hurs_list7 := array_append_record(hurs_list7, hursGrid7, 0)
        hurs_list8 := array_append_record(hurs_list8, hursGrid8, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(hurs_list1(366:11323)) ;; 366->1971:00:00, 11323->366+10958-1->2000:12:31
    nor_par(1) = sqrt(variance(hurs_list1(366:11323)))
    nor_par(2) = avg(hurs_list2(366:11323))
    nor_par(3) = sqrt(variance(hurs_list2(366:11323)))
    nor_par(4) = avg(hurs_list3(366:11323))
    nor_par(5) = sqrt(variance(hurs_list3(366:11323)))
    nor_par(6) = avg(hurs_list4(366:11323))
    nor_par(7) = sqrt(variance(hurs_list4(366:11323)))
    nor_par(8) = avg(hurs_list5(366:11323))
    nor_par(9) = sqrt(variance(hurs_list5(366:11323)))
    nor_par(10) = avg(hurs_list6(366:11323))
    nor_par(11) = sqrt(variance(hurs_list6(366:11323)))
    nor_par(12) = avg(hurs_list7(366:11323))
    nor_par(13) = sqrt(variance(hurs_list7(366:11323)))
    nor_par(14) = avg(hurs_list8(366:11323))
    nor_par(15) = sqrt(variance(hurs_list8(366:11323)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    hursFiles = systemfunc("ls " + mainPath + "/historical/hurs*.nc")

    hurs_list1 = new((/1/), double, 0)
    hurs_list2 = new((/1/), double, 0)
    hurs_list3 = new((/1/), double, 0)
    hurs_list4 = new((/1/), double, 0)
    hurs_list5 = new((/1/), double, 0)
    hurs_list6 = new((/1/), double, 0)
    hurs_list7 = new((/1/), double, 0)
    hurs_list8 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 4
        f = addfile(hursFiles(i), "r")
        hurs := flt2dble(f->hurs) ;; todouble()不能保存metadata，flt2dble()可以。
        hursT42 := f2gsh_Wrap(hurs, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := hursT42(:,43,34)
        hursGrid1 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := hursT42(:,40,35)
        hursGrid2 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := hursT42(:,41,35)
        hursGrid3 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := hursT42(:,42,35)
        hursGrid4 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := hursT42(:,43,35)
        hursGrid5 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := hursT42(:,39,36)
        hursGrid6 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := hursT42(:,40,36)
        hursGrid7 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := hursT42(:,41,36)
        hursGrid8 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        hurs_list1 := array_append_record(hurs_list1, hursGrid1, 0)
        hurs_list2 := array_append_record(hurs_list2, hursGrid2, 0)
        hurs_list3 := array_append_record(hurs_list3, hursGrid3, 0)
        hurs_list4 := array_append_record(hurs_list4, hursGrid4, 0)
        hurs_list5 := array_append_record(hurs_list5, hursGrid5, 0)
        hurs_list6 := array_append_record(hurs_list6, hursGrid6, 0)
        hurs_list7 := array_append_record(hurs_list7, hursGrid7, 0)
        hurs_list8 := array_append_record(hurs_list8, hursGrid8, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_input_file/hurs_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/mirhrhumg1.dat"
    write_matrix(transpose(hurs_list1(1:16436)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/mirhrhumg2.dat"
    write_matrix(transpose(hurs_list2(1:16436)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/mirhrhumg3.dat"
    write_matrix(transpose(hurs_list3(1:16436)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/mirhrhumg4.dat"
    write_matrix(transpose(hurs_list4(1:16436)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/mirhrhumg5.dat"
    write_matrix(transpose(hurs_list5(1:16436)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/mirhrhumg6.dat"
    write_matrix(transpose(hurs_list6(1:16436)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/mirhrhumg7.dat"
    write_matrix(transpose(hurs_list7(1:16436)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/mirhrhumg8.dat"
    write_matrix(transpose(hurs_list8(1:16436)), "f9.3", opt8)

end