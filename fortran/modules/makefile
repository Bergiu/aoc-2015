MODULES = $(wildcard *.f08)
MODULES_OBJ = $(patsubst %.f08,%.o,$(MODULES))
MODULES_MOD = $(patsubst %.f08,%.mod,$(MODULES))
F08 = gfortran

$(MODULES_OBJ) : $(MODULES)
	$(F08) -c $^

.PHONY: clean
clean:
	@rm -f *.o
	@rm -f *.mod

.PHONY: modules
modules:$(MODULES_OBJ)
