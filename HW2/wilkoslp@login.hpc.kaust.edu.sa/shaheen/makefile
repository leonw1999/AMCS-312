include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules

CFLAGS += -pedantic -std=c99

EXECS = ps2-1D ps2-2D ps2-3D ps2-1D_ex4a ps2-2D_ex4a ps2-3D_ex4a ps2-1D_ex4b ps2-2D_ex4b ps2-3D_ex4b

all: $(EXECS)

ps2-1D: ps2-1D.o
	-${CLINKER} -o ps2-1D ps2-1D.o ${PETSC_LIB} -lm
	${RM} ps2-1D.o

ps2-2D: ps2-2D.o
	-${CLINKER} -o ps2-2D ps2-2D.o ${PETSC_LIB} -lm
	${RM} ps2-2D.o

ps2-3D: ps2-3D.o
	-${CLINKER} -o ps2-3D ps2-3D.o ${PETSC_LIB} -lm
	${RM} ps2-3D.o

ps2-1D_ex4a: ps2-1D_ex4a.o
	-${CLINKER} -o ps2-1D_ex4a ps2-1D_ex4a.o ${PETSC_LIB} -lm
	${RM} ps2-1D_ex4a.o

ps2-2D_ex4a: ps2-2D_ex4a.o
	-${CLINKER} -o ps2-2D_ex4a ps2-2D_ex4a.o ${PETSC_LIB} -lm
	${RM} ps2-2D_ex4a.o

ps2-3D_ex4a: ps2-3D_ex4a.o
	-${CLINKER} -o ps2-3D_ex4a ps2-3D_ex4a.o ${PETSC_LIB} -lm
	${RM} ps2-3D_ex4a.o

ps2-1D_ex4b: ps2-1D_ex4b.o
	-${CLINKER} -o ps2-1D_ex4b ps2-1D_ex4b.o ${PETSC_LIB} -lm
	${RM} ps2-1D_ex4b.o

ps2-2D_ex4b: ps2-2D_ex4b.o
	-${CLINKER} -o ps2-2D_ex4b ps2-2D_ex4b.o ${PETSC_LIB} -lm
	${RM} ps2-2D_ex4b.o

ps2-3D_ex4b: ps2-3D_ex4b.o
	-${CLINKER} -o ps2-3D_ex4b ps2-3D_ex4b.o ${PETSC_LIB} -lm
	${RM} ps2-3D_ex4b.o

.PHONY: clean distclean

distclean: clean

clean::
	@rm -f *~ ps2-1D ps2-2D ps2-3D ps2-1D_ex4a ps2-2D_ex4a ps2-3D_ex4a ps2-1D_ex4b ps2-2D_ex4b ps2-3D_ex4b *tmp
