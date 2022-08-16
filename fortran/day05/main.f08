module day05
    use io
    use strings
    use string_list
    implicit none
contains
    function amount_vowels(line) result(res)
        character(len=*), intent(in) :: line
        character(len=1) :: char
        integer :: res, pos, i
        res = 0
        do i=1, len(line)
            char = line(i:i)
            pos = INDEX("aeiou", char)
            if (pos /= 0) then
                res = res + 1
            end if
        end do
    end function

    function amount_twices(line) result(res)
        character(len=*), intent(in) :: line
        integer :: res, i
        res = 0
        do i=1, len(line) - 1
            if (line(i:i) == line(i+1:i+1)) then
                res = res + 1
            end if
        end do
    end function

    function contains_illegal_strings(line) result(res)
        character(len=*), intent(in) :: line
        logical :: res
        res = INDEX(line, "ab") /= 0 &
            .or. INDEX(line, "cd") /= 0 &
            .or. INDEX(line, "pq") /= 0 &
            .or. INDEX(line, "xy") /= 0
    end function

    function is_nice(line) result(res)
        character(len=*), intent(in) :: line
        logical :: res
        res = (amount_vowels(line) >= 3) &
            .and. (amount_twices(line) >= 1) &
            .and. .not. contains_illegal_strings(line)
    end function

    function amount_nice(content) result(res)
        character(len=*), intent(in) :: content
        character(len=:), allocatable :: tail, line
        integer :: res, consumed, i
        tail = content
        consumed = 0
        res = 0
        do while(consumed /= len(content))
            call split_next_line(tail, line, consumed)
            if (is_nice(line)) then
                res = res + 1
            end if
        end do
    end function

    function amount_nice_alternative(content) result(res)
        character(len=*), intent(in) :: content
        type(str), dimension(:), allocatable :: lines
        type(str) :: line
        integer :: res, i
        lines = split_lines(content)
        res = 0
        do i=1, size(lines)
            line = lines(i)
            if (is_nice(-line)) then
                res = res + 1
            end if
        end do
    end function

    function part01(filename) result(res)
        character(len=*), intent(in) :: filename
        character(len=:), allocatable :: content
        integer :: res
        content = read_file(filename)
        res = amount_nice(content)
    end function
end module

program main
    use day05
    use string_list
    implicit none
    integer :: val
    ! call example_split_next_line()
    ! call example_split_lines()
    val = part01("input.txt")
    print*, "Part 01:", val
    ! val = part02("input.txt")
    ! print*, "Part 02:", val
end program
