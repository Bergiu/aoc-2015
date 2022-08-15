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
