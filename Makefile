# src files list
src_f90l1 = \
fftpack.f90 \
fftpack5.f90 \
forlab.f90

src_f90l2 = \
example_fft.f90

# obj files list
obj_f90l1 = \
fftpack.o \
fftpack5.o \
forlab.o

obj_f90l2 = \
example_fft.o

# src files dir
src_f90d1 = ./src/
src_f90d2 = ./test/

# obj files dir
obj_dir = ./obj/example_fft/

# exe file dir/name
exe_dir = ./bin/
exe = example_fft

# lib files
idir = 
ldir = 
libs =

# examples
example_dir = ./example/

# make configuration
VPATH = $(src_f90d1):$(src_f90d2):$(obj_dir)
objs = $(addprefix $(obj_dir), $(obj_f90l1) $(obj_f90l2))

# compiler tools
fc = gcc
ld = gfortran
fflag = -o3 -cpp -ffast-math -march=native -funroll-loops -fno-protect-parens -flto -fcheck=all -fallow-argument-mismatch \
-Wl, -J$(obj_dir) $(idir)
lflag = 

# targets
all: $(exe)

$(exe): $(obj_f90l1) $(obj_f90l2)
	@mkdir -p $(exe_dir)
	$(ld) -o $(exe_dir)$(exe) $(objs) $(lflag) $(libs) $(ldir)
	
$(obj_f90l1):
	@mkdir -p $(obj_dir)
	$(fc) $(fflag) -c $(src_f90d1)$(@:.o=.f90) -o $(obj_dir)$@

$(obj_f90l2):
	@mkdir -p $(obj_dir)
	$(fc) $(fflag) -c $(src_f90d2)$(@:.o=.f90) -o $(obj_dir)$@
	
.PHONY: clean, test
clean:
	rm -f $(obj_dir)*.*
	rm -f $(exe_dir)$(exe)

test:
	@mkdir -p $(example_dir)
	cd $(example_dir); ../$(exe_dir)$(exe)
	
# dependencies of files
example_fft.o: \
example_fft.f90 \
forlab.o \
fftpack.o \
fftpack5.o

fftpack.o: \
fftpack.f90

fftpack5.o: \
fftpack5.f90

forlab.o: \
forlab.f90