module io
    use strings
    use string_list
    implicit none

    private
    public :: read_file, read_lines
contains
    function read_file(filename) result(res)
        ! reads a file and returns the text
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

    function read_lines(filename) result(res)
        ! reads a file and returns an array of lines
        character(len=*), intent(in) :: filename
        type(str), dimension(:), allocatable :: res
        res = split_lines(read_file(filename))
    end function
end module
