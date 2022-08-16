module day01
    use io
    implicit none

contains
    function count_floor(content) result(res)
        character(len=*), intent(in) :: content
        character(len=1) :: char
        integer                       :: i, res
        res = 0
        do i = 1, len(content)
            char = content(i:i)
            if (char == "(") then
                res = res + 1
            else if (char == ")") then
                res = res - 1
            end if
        end do
    end function

    function part01(filename) result(res)
        character(len=*), intent(in) :: filename
        integer          :: res
        res = count_floor(read_file(filename))
    end function

    subroutine test_count_floor()
        if (count_floor("(())") /= 0) stop "Test count floor failed!"
        if (count_floor("()()") /= 0) stop "Test count floor failed!"
        if (count_floor("(((") /= 3) stop "Test count floor failed!"
        if (count_floor("(()(()(") /= 3) stop "Test count floor failed!"
        if (count_floor("))(((((") /= 3) stop "Test count floor failed!"
        if (count_floor("())") /= -1) stop "Test count floor failed!"
        if (count_floor("))(") /= -1) stop "Test count floor failed!"
        if (count_floor(")))") /= -3) stop "Test count floor failed!"
        if (count_floor(")())())") /= -3) stop "Test count floor failed!"
    end subroutine

    subroutine test_part01()
        if (part01("input_test.txt") /= 2) stop "Test part 01 failed!"
    end subroutine

    function count_position(content) result(res)
        character(len=*), intent(in) :: content
        character(len=1) :: char
        integer :: res, floor, i
        floor = 0
        res = 0
        do i = 1, len(content)
            char = content(i:i)
            if (char == "(") then
                floor = floor + 1
            else if (char == ")") then
                floor = floor - 1
            end if
            if (res == 0 .and. floor < 0) res = i
        end do
    end function

    function part02(filename) result(res)
        character(len=*), intent(in) :: filename
        integer          :: res
        res = count_position(read_file(filename))
    end function

    subroutine test_count_position()
        if (count_position(")") /= 1) stop "Test count floor failed!"
        if (count_position("()())") /= 5) stop "Test count floor failed!"
    end subroutine

    subroutine test_part02()
        integer :: val
        character(len=100) :: err
        val = part02("input_test2.txt")
        write (err, *) "Test failed! Expected 5 got ", val
        if (val /= 5) stop err
    end subroutine
end module

program main
    use day01
    use io
    call test_count_floor()
    call test_count_position()
    call test_part01()
    call test_part02()
    print *, "Part 1: ", part01("input.txt")
    print *, "Part 2: ", part02("input.txt")
end program main
