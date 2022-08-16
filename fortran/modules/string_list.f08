module string_list
    implicit none

    private :: example, assa, get

    type, public :: str
        character(:), allocatable :: s
    contains
        procedure, private :: assa, get
        generic, public :: assignment(=) => assa
        generic, public :: operator(-) => get
    end type
contains
    subroutine assa(st, str1)
        class(str), intent(out) :: st
        character(len=*), intent(in) :: str1
        st%s = str1
    end subroutine

    function get(st1) result(str1)
        class(str), intent(in) :: st1
        character(:), allocatable :: str1
        str1 = st1%s
    end function

    subroutine example()
        type(str) :: st
        type(str), dimension(:), allocatable :: stra
        st = "hello"
        print*, -st, len(-st)
        allocate(stra(2))
        stra(1) = "hello "
        stra(2) = "fortran"
        print*, -stra(1)
        print*, -stra(1)//-stra(2)
        print*, len(-stra(1)), len(-stra(2))
    end subroutine
end module

