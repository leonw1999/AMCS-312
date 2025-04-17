include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules

CFLAGS += -pedantic -std=c99

ps2: ps2.o
	-${CLINKER} -o ps2 ps2.o ${PETSC_LIB}
	${RM} ps2.o

ps2-1D: ps2-1D.o
	-${CLINKER} -o ps2-1D ps2-1D.o ${PETSC_LIB}
	${RM} ps2-1D.o

.PHONY: clean distclean

distclean: clean

clean::
	@rm -f *~ ps2 ps2-1D *tmp
