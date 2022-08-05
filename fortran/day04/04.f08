! shit code
! too slow
module strings
    implicit none

contains
    function read_file(filename) result(res)
        character(len=*), intent(in) :: filename
        character(len=1) :: reader
        character(len=:), allocatable :: res
        integer :: i, ios, fu
        open(newunit=fu, file=filename, iostat=ios, &
             access="stream", form="unformatted", action="read")
        if (ios /= 0) stop "Error: opening file failed."
        res = ""
        i = 0
        do
            read(fu, iostat=ios) reader
            if (ios /= 0) exit
            res = res // reader
            i = i + 1
        end do
        close(fu)
    end function
end module

module md5_mod
    use strings
    implicit none

contains
    function md5sum(content) result(res)
        character(len=*), intent(in) :: content
        character(len=:), allocatable :: res, command, tmp
        integer :: nn
        ! save result in file and read file
        command = "echo -n " // content // "| md5sum | cut -d ' ' -f1 > tmp.txt"
        call execute_command_line(command)
        tmp = read_file("tmp.txt")
        res = tmp(:len(tmp)-1) ! remove newline
    end function

    subroutine test_md4sum()
        character(len=:), allocatable :: val, err
        val = md5sum("abcdef609043")
        err = "Test failed! Expected 000001dbbfa3a5c83a2d506429c7b00e got " // val
        if (val /= "000001dbbfa3a5c83a2d506429c7b00e") stop err
        val = md5sum("pqrstuv1048970")
        err = "Test failed! Expected 000006136ef2ff3b291c85725f17325c got " // val
        if (val /= "000006136ef2ff3b291c85725f17325c") stop err
    end subroutine
end module

module day04
    use strings
    use md5_mod
    implicit none
contains
    function to_string(int) result(res)
        integer, intent(in) :: int
        character(len=100) :: res
        write(res,*) int
        res = adjustl(res)
    end function

    function calculate_5(content, hint) result(res)
        character(len=*), intent(in) :: content
        integer, intent(in) :: hint
        character(len=100) :: tmp
        character(len=:), allocatable :: md5, tmp2
        integer :: res
        res = hint
        do
            tmp = to_string(res)
            tmp2 = content // trim(tmp)
            md5 = md5sum(tmp2)
            if (md5(:5) == "00000") then
                exit
            end if
            res = res + 1
        end do
    end function

    function calculate_6(content, hint) result(res)
        character(len=*), intent(in) :: content
        integer, intent(in) :: hint
        character(len=100) :: tmp
        character(len=:), allocatable :: md5, tmp2
        integer :: res
        res = hint
        do
            tmp = to_string(res)
            tmp2 = content // trim(tmp)
            md5 = md5sum(tmp2)
            if (md5(:6) == "000000") then
                exit
            end if
            res = res + 1
        end do
    end function

    subroutine test_calculate_5()
        character(len=:), allocatable :: err
        integer :: val
        val = calculate_5("abcdef", 609000)
        if (val /= 609043) stop
        val = calculate_5("pqrstuv", 1040000)
        if (val /= 609043) stop
    end subroutine

    function part01(filename) result(res)
        character(len=*), intent(in) :: filename
        character(len=:), allocatable :: content
        integer :: res
        content = read_file(filename)
        res = calculate_5(content(:len(content)-1), 250000)
    end function

    function part02(filename) result(res)
        character(len=*), intent(in) :: filename
        character(len=:), allocatable :: content
        integer :: res
        content = read_file(filename)
        res = calculate_6(content(:len(content)-1), 1038000)
    end function
end module

program main
    use day04
    integer :: val
    call test_md4sum()
    ! call test_calculate_5()
    val = part01("input.txt")
    print*, "Part 01:", val
    val = part02("input.txt")
    print*, "Part 02:", val
end program
