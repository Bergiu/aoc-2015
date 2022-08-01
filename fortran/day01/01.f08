module day01
    implicit none

contains
    function part01(filename) result(res)
        character(len=*) :: filename
        character(len=1) :: char
        integer          :: ios, fu, i, res
        open(newunit=fu, file=filename, iostat=ios, &
             access="stream", form="unformatted", action="read")
        if (ios /= 0) stop "Error: opening file failed."
        res = 0
        i = 0
        do
            read(fu, iostat=ios) char
            if (ios /= 0) exit
            if (char == "(") then
                res = res + 1
            else if (char == ")") then
                res = res - 1
            end if
            i = i + 1
        end do
        close(10)
    end function

    subroutine test_day01()
        if (part01("input_test.txt") /= 2) stop "Test failed!"
    end subroutine

    function part02(filename) result(res)
        character(len=*) :: filename
        character(len=1) :: char
        integer          :: ios, fu, i, floor, res
        open(newunit=fu, file=filename, iostat=ios, &
             access="stream", form="unformatted", action="read")
        if (ios /= 0) stop "Error: opening file failed."
        res = 0
        i = 1
        floor = 0
        do
            read(fu, iostat=ios) char
            if (ios /= 0) exit
            if (char == "(") then
                floor = floor + 1
            else if (char == ")") then
                floor = floor - 1
            end if
            if (res == 0 .and. floor < 0) res = i
            i = i + 1
        end do
        close(10)
    end function

    subroutine test_day02()
        integer :: val
        character(len=100) :: err
        val = part02("input_test2.txt")
        write (err, *) "Test failed! Expected 5 got ", val
        if (val /= 5) stop err
    end subroutine
end module

program main
    use day01
    call test_day01()
    call test_day02()
    print *, "Part 1: ", part01("input.txt")
    print *, "Part 2: ", part02("input.txt")
end program main
