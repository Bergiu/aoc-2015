INCLUDES = ../modules/
MODULES = $(wildcard ../modules/*.f08)
MODULES_OBJ = $(patsubst %.f08,%.o,$(MODULES))
F08 = gfortran
MAKE = make

main:
	$(MAKE) -C ../modules/
	$(F08) -I $(INCLUDES) -o main.out $(MODULES_OBJ) main.f08

clean:
	$(MAKE) -C ../modules/ clean
	@rm -f main.out
	@rm -f *.mod
