module day03
    use io
    implicit none
contains
    function calculate_houses(content) result(res)
        character(len=*), intent(in) :: content
        character(len=1) :: char
        integer, dimension(len(content) + 1, 2) :: houses
        integer :: res, i, y, x, j
        logical :: new_element
        res = 1
        x = 0
        y = 0
        ! start position is also a house
        houses(1,1) = 0
        houses(1,2) = 0
        do i = 2, len(content) + 1
            char = content(i-1:i-1)
            select case (char)
            case ("^")
                y = y + 1
            case ("v")
                y = y - 1
            case (">")
                x = x + 1
            case ("<")
                x = x - 1
            end select
            houses(i,1) = x
            houses(i,2) = y
            ! check if it is new
            new_element = .true.
            do j = 1, i - 1
                if (houses(j,1) == x .and. houses(j,2) == y) then
                    new_element = .false.
                    exit
                end if
            end do
            if (new_element) then
                res = res + 1
            end if
        end do
    end function

    function calculate_houses_dual(content) result(res)
        character(len=*), intent(in) :: content
        character(len=1) :: char
        integer, dimension(len(content) + 1, 2) :: houses
        integer :: res, i, y_santa, x_santa, y_robo, x_robo, j, x, y
        logical :: new_element, santa
        res = 1
        x_santa = 0
        y_santa = 0
        x_robo = 0
        y_robo = 0
        santa = .true.
        ! start position is also a house
        houses(1,1) = 0
        houses(1,2) = 0
        do i = 2, len(content) + 1
            char = content(i-1:i-1)
            if (santa) then
                x = x_santa
                y = y_santa
            else
                x = x_robo
                y = y_robo
            end if
            select case (char)
            case ("^")
                y = y + 1
            case ("v")
                y = y - 1
            case (">")
                x = x + 1
            case ("<")
                x = x - 1
            end select
            if (santa) then
                x_santa = x
                y_santa = y
            else
                x_robo = x
                y_robo = y
            end if
            houses(i,1) = x
            houses(i,2) = y
            santa = .not. santa
            ! check if it is new
            new_element = .true.
            do j = 1, i - 1
                if (houses(j,1) == x .and. houses(j,2) == y) then
                    new_element = .false.
                    exit
                end if
            end do
            if (new_element) then
                res = res + 1
            end if
        end do
    end function

    function part01(filename) result(res)
        character(len=*), intent(in) :: filename
        character(len=:), allocatable :: content
        integer :: res
        content = read_file(filename)
        res = calculate_houses(content)
    end function

    function part02(filename) result(res)
        character(len=*), intent(in) :: filename
        character(len=:), allocatable :: content
        integer :: res
        content = read_file(filename)
        res = calculate_houses_dual(content)
    end function
end module

program main
    use day03
    use io
    integer val
    val = part01("input.txt")
    print *, "Part 1: ", val
    val = part02("input.txt")
    print *, "Part 2: ", val
end program main
