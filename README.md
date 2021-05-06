# FFTPack
FFTPack aims to provide an easily usable package of functions using FFTPack library (Fortran 77).

## Two libraries
This repo contains two libraries:
1. FFTpack library  
   Contains FFT functions.
2. Forlab library  
   Forlab is a Fortran module that provides a lot of functions for scientific computing 
   mostly inspired by Matlab and Python's package NumPy.

## Getting started
```bash
git clone https://github.com/zoziha/FFTPack.git
cd FFTPack

```

## Requirements
To build this library you need
+ gfortran version > 10 (better or you need to modify the makefile)
+ gnu make
+ terminal `bash`

## Make & test
```bash
# executable program
make
make test

# fftpack lib and its includes
make fftpack

```
When you `make` this repo, you will get a executable program `example_fft.exe` in ./bin dir, you type `make test` 
to run it automatically.

When you type `make fftpack`, you will get two compiled library files (dynamic and static versions availabe: dll.a/.a) 
in "./bin" path and header files in "./bin/include" path. That you can distribute them (fftpack and forlab libraries).


## Link
[keurfonluu/FFTPack](https://github.com/keurfonluu/FFTPack)  
[keurfonluu/Forlab](https://github.com/keurfonluu/Forlab)
