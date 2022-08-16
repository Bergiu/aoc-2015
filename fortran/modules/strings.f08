module strings
    use string_list
    implicit none

    private
    public :: split, count
    public :: amount_lines, split_next_line, split_lines
    public :: example_split_next_line, example_split_lines

contains
    subroutine split(substring, content, head, counter)
        ! head will contain the line and content will be manipulated
        ! and contains the rest of the text. the amount of chars consumed
        ! will be added to counter.
        character(len=*),              intent(in)    :: substring
        character(len=:), allocatable, intent(inout) :: content
        character(len=:), allocatable, intent(out)   :: head
        integer,                       intent(inout) :: counter
        integer                                      :: pos
        pos = INDEX(content, substring)
        if (pos /= 0) then
            counter = counter + pos
            head = content(:pos-1)
            content = content(pos+1:)
        else ! no newline
            counter = counter + len(content)
            head = content
            content = ""
        end if
    end subroutine

    subroutine split_next_line(content, head, counter)
        ! head will contain the line and content will be manipulated
        ! and contains the rest of the text. the amount of chars consumed
        ! will be added to counter.
        character(len=:), allocatable, intent(inout) :: content
        character(len=:), allocatable, intent(out)   :: head
        integer,                       intent(inout) :: counter
        call split(achar(10), content, head, counter)
    end subroutine

    function count(substring, content) result(res)
        character(len=*), intent(in) :: content, substring
        integer :: res, pos, relpos
        relpos = INDEX(content, substring)
        pos = relpos
        res = 1
        do while(relpos /= 0)
            relpos = INDEX(content(pos+1:), substring)
            pos = pos + relpos
            res = res + 1
        end do
    end function

    function amount_lines(content) result(res)
        ! Returns the amount of lines in content. If the last line is empty, one
        ! is subtracted. This is the case for most files.
        character(len=*), intent(in) :: content
        integer :: res
        res = count(achar(10), content)
        ! empty last line
        if (INDEX(content, achar(10), BACK=.true.) == len(content)) then
            res = res - 1
        end if
    end function

    function split_lines(content) result(res)
        ! Returns an array of strings. Each element is one line in content.
        character(len=*), intent(in) :: content
        character(len=:), allocatable :: tail, line
        type(str), dimension(:), allocatable :: res
        integer :: consumed, amount_newlines, i
        amount_newlines = amount_lines(content)
        allocate(res(amount_newlines))
        tail = content
        consumed = 0
        i = 1
        do while(consumed /= len(content))
            call split_next_line(tail, line, consumed)
            res(i) = line
            i = i + 1
        end do
    end function

    subroutine example_split_lines()
        ! Example on how to use the split_next_line subroutine.
        character(len=*), parameter :: content = "Hallo" // achar(10) // "Welt" // achar(10) // "Dritte"
        type(str), dimension(:), allocatable :: lines
        ! character(len=:), allocatable :: content2
        integer i
        lines = split_lines(content)
        do i=1, size(lines)
            print*, -lines(i)
        end do
        ! content2 = read_file("test.txt")
        ! lines = split_lines(content2)
        ! do i=1, size(lines)
        !     print*, -lines(i)
        ! end do
    end subroutine

    subroutine example_split_next_line()
        ! Example on how to use the split_next_line subroutine.
        character(len=*), parameter :: content = "Hallo" // achar(10) // "Welt" // achar(10) // "Dritte"
        character(len=:), allocatable :: tail, head
        integer :: consumed, i
        tail = content
        consumed = 0
        i = 1
        do while(consumed /= len(content))
            call split_next_line(tail, head, consumed)
            print*, i, head
            i = i + 1
        end do
    end subroutine

end module
