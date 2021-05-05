#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!  Copyright (c) 2015 by
#!  Magnitude, France  and  MINES ParisTech, France
#!  All rights reserved.
#!
#!  This software is furnished under a license and may be used and copied
#!  only in  accordance with  the  terms  of  such  license  and with the
#!  inclusion of the above copyright notice. This software or  any  other
#!  copies thereof may not be provided or otherwise made available to any
#!  other person.  No title to and ownership of  the  software is  hereby
#!  transferred.
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
#         Makefile for Fortran programs
#
# ======================================================================
# Declarations for compiler (comment or decomment as necessary)
# ======================================================================
#
# ---- Gnu complier (gcc)
FC      :=  gfortran
#
# ---- Gnu MPI compiler
# FC      :=  mpif90
#
# flags for debugging or for maximum performance or MPI, comment as necessary
#
# ---- Option for gfortran compiler
#FFLAGS  :=  -Ofast
#FFLAGS  :=  -O3 -ffree-line-length-none
#FFLAGS  :=  -O3 -ffree-line-length-none -Wall -Wextra -fbounds-check
#FFLAGS  :=  -O3 -ffree-line-length-none -cpp -Ddo_mpi
## gfortran10: Mismatches between actual and dummy argument lists in a single file are now rejected with an error
## https://github.com/NCAR/ncl/issues/123
FFLAGS  :=  -O3 -ffast-math -march=native -funroll-loops -fno-protect-parens -flto -fcheck=all -fallow-argument-mismatch
#
# ======================================================================
# Declarations of executables to be compiled and various dependances
# ======================================================================
# Name of executable
TARGET  :=  example_fft.exe

# Directories
SRCDIR  :=  src
OBJDIR  :=  obj
MAIN    :=  $(SRCDIR)

# Link objects to create executable (tab required on second line)
OBJS    :=  $(OBJDIR)/forlab.o \
            $(OBJDIR)/fftpack5.o \
            $(OBJDIR)/fftpack.o \
            $(OBJDIR)/example_fft.o

# These routines depend on include file - recompile if include modified

ALL     :=  $(TARGET)
all: $(ALL)

# ======================================================================
# General rules, these should not require modification
# General rules for building ".o" objects from fortran programs or subroutines
# ======================================================================

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(OBJDIR)/fftpack5.o: $(MAIN)/fftpack5.f90 | $(OBJDIR)
	$(FC) $(FFLAGS) -w -c $^ -o $@ -J$(OBJDIR)

$(OBJDIR)/%.o: $(MAIN)/%.f90 | $(OBJDIR)
	$(FC) $(FFLAGS) -c $^ -o $@ -J$(OBJDIR)

$(TARGET): $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS)

# Utilities

.PHONY: all clean veryclean

clean:
	rm -rf $(ALL) $(OBJDIR)

veryclean:
	rm -rf $(ALL) $(OBJDIR)

# ======================================================================
# That's all
# ======================================================================
