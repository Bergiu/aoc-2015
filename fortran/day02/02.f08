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

    subroutine test_read_file()
        character(len=:), allocatable :: content
        character(len=7) :: expected
        character(len=100) :: err
        content = read_file("input_test.txt")
        expected = "(((())" // achar(10)  ! 10=newline
        write (err, *) "Test failed! Expected ",expected," got ", content
        if (content /= expected) stop err
    end subroutine
end module

module box_mod
    type box
        integer :: h, l, w
    end type
contains
    function new_box(h, l, w) result(boxed)
        integer, intent(in) :: h, l, w
        type(box) :: boxed
        boxed%h = h
        boxed%l = l
        boxed%w = w
    end function
end module

module box_list_mod
    use box_mod

    public :: new
    private :: add, get, get_all

    type, public :: box_list
        private
        type(box), dimension(:), allocatable :: items
        integer :: size_
    contains
        procedure, public :: capacity => get_capacity
        procedure, public :: size => get_size
        procedure, public :: add => add
        procedure, public :: add_new => add_new
        procedure, public :: get => get
        procedure, public :: get_all => get_all
        procedure, private :: increase_size => increase_size
    end type

contains
    subroutine init(list)
        type(box_list), intent(out) :: list
        list%size_ = 0
        allocate(list%items(5))
    end subroutine

    function get_capacity(this) result(cap)
        class(box_list), intent(in) :: this
        integer :: cap
        cap = size(this%items)
    end function

    function get_size(this) result(size)
        class(box_list), intent(in) :: this
        integer :: size
        size = this%size_
    end function

    subroutine add_new(this, h, l, w)
        class(box_list), intent(inout) :: this
        integer, intent(in) :: h, l, w
        type(box) :: item
        item = new_box(h, l, w)
        call this%add(item)
    end subroutine

    subroutine increase_size(this)
        class(box_list), intent(inout) :: this
        type(box), dimension(:), allocatable :: tmp
        new_capacity = size(this%items) * 2
        allocate(tmp(new_capacity))
        tmp(1:size(this%items)) = this%items(1:size(this%items))
        call move_alloc(tmp, this%items)
    end subroutine

    subroutine add(this, item)
        class(box_list), intent(inout) :: this
        type(box), intent(inout) :: item
        ! index starts with 1
        if (this%size_ < size(this%items)) then
            this%size_ = this%size_ + 1
            this%items(this%size_) = item
        else
            call this%increase_size()
            this%size_ = this%size_ + 1
            this%items(this%size_) = item
        end if
    end subroutine

    subroutine get(this, index, err, item)
        class(box_list), intent(in)  :: this
        integer,         intent(in)  :: index
        logical,         intent(out) :: err
        type(box),       intent(out) :: item
        if (index <= this%size_) then
            item = this%items(index)
            err = .false.
        else
            err = .true.
        end if
    end subroutine

    function get_all(this) result(list)
        class(box_list), intent(in) :: this
        type(box), dimension(:), allocatable :: list
        if (this%size_ > 0) then
            list = this%items(1:this%size_)
        else
            allocate(list(0))
        end if
    end function
end module

module day02
    use box_mod
    use box_list_mod
contains
    function read_file(filename) result(res)
        implicit none
        character(len=*), intent(in) :: filename
        character(len=1) :: reader
        character(len=:), allocatable :: num
        type(box), dimension(:), allocatable :: res
        type(box_list) :: list
        integer :: h, l, w, pos, i
        integer :: fu, ios, stat
        call init(list)
        open(newunit=fu, file=filename, iostat=ios, &
             access="stream", form="unformatted", action="read")
        if (ios /= 0) stop "Error: opening file failed."
        pos = 0
        i = 1
        num = ""
        do
            read(fu, iostat=ios) reader
            if (ios /= 0) exit
            if (reader == "x" .or. reader == achar(10)) then
                select case (pos)
                    case (0)
                        read(num, *, iostat=stat) h
                    case (1)
                        read(num, *, iostat=stat) l
                    case (2)
                        read(num, *, iostat=stat) w
                end select
                num = ""
                if (reader == achar(10)) then
                    pos = 0
                    call list%add_new(h, l, w)
                else
                    pos = pos + 1
                end if
            else
                num = num // reader
            end if
        end do
        close(fu)
        res = list%get_all()
    end function

    function calculate_paper(list) result(res)
        type(box), dimension(:), intent(in) :: list
        type(box) :: item
        integer :: res, a, b, c
        res = 0
        do i = 1, size(list)
            item = list(i)
            a = item%l*item%w
            b = item%w*item%h
            c = item%h*item%l
            res = res + 2*(a+b+c) + min(a, b, c)
        end do
    end function

    function calculate_ribbon(list) result(res)
        type(box), dimension(:), intent(in) :: list
        type(box) :: item
        integer :: res, a, b, c
        res = 0
        do i = 1, size(list)
            item = list(i)
            a = min(item%l, item%w)
            b = min(item%w, item%h)
            c = min(item%h, item%l)
            min1 = min(a, b, c)
            min2 = max(a, b, c)
            res = res + (min1 + min2) * 2 + item%l * item%w * item%h
        end do
    end function

    subroutine test_calculate_paper()
        integer :: val
        character(len=100) :: err
        type(box), dimension(1) :: list
        type(box), dimension(2) :: list2
        list(1) = new_box(2, 3, 4)
        val = calculate_paper(list)
        write (err, *) "Test failed! Expected 58 got ", val
        if (val /= 58) stop err
        list(1) = new_box(1, 1, 10)
        val = calculate_paper(list)
        write (err, *) "Test failed! Expected 43 got ", val
        if (val /= 43) stop err
        list2(1) = new_box(2, 3, 4)
        list2(2) = new_box(1, 1, 10)
        val = calculate_paper(list2)
        write (err, *) "Test failed! Expected 101 got ", val
        if (val /= 101) stop err
    end subroutine

    subroutine test_calculate_ribbon()
        integer :: val
        character(len=100) :: err
        type(box), dimension(1) :: list
        type(box), dimension(2) :: list2
        list(1) = new_box(2, 3, 4)
        val = calculate_ribbon(list)
        write (err, *) "Test failed! Expected 34 got ", val
        if (val /= 34) stop err
        list(1) = new_box(1, 1, 10)
        val = calculate_ribbon(list)
        write (err, *) "Test failed! Expected 14 got ", val
        if (val /= 14) stop err
        list2(1) = new_box(2, 3, 4)
        list2(2) = new_box(1, 1, 10)
        val = calculate_ribbon(list2)
        write (err, *) "Test failed! Expected 48 got ", val
        if (val /= 48) stop err
    end subroutine

    function part01() result(res)
        integer res
        type(box), dimension(:), allocatable :: content
        content = read_file("input.txt")
        res = calculate_paper(content)
    end function

    function part02() result(res)
        integer res
        type(box), dimension(:), allocatable :: content
        content = read_file("input.txt")
        res = calculate_ribbon(content)
    end function
end module

program main
    use day02
    implicit none
    integer :: val
    call test_calculate_paper()
    call test_calculate_ribbon()
    val = part01()
    print *, "Part 1: ", val
    val = part02()
    print *, "Part 2: ", val
end program
