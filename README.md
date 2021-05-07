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

## Compilation method 1: make & test

### Requirements
To build this library you need
+ gfortran version > 10 (better or you need to modify the makefile: remove the '-fallow-argument-mismatch' flag)
+ gnu make
+ terminal `bash`

### make
```bash
# executable program
make
make test

# fftpack lib and its includes
make fftpack
```
When you `make` this repo, you will get a executable program `example_fft.exe` in the "./bin" folder, you type `make test` 
to run it automatically.

When you type `make fftpack`, you will get two compiled library files (dynamic and static versions availabe: dll.a/.a) 
in the "./bin" folder and header files in the "./bin/include" folder. That you can distribute them (fftpack and forlab libraries).

## Compilation method 2: [fpm](https://github.com/fortran-lang/fpm)

### Requirements
To build this library you need
+ gfortran
+ [fpm](https://github.com/fortran-lang/fpm)

### Fpm build
```bash
# gfortran version < 10
fpm build

# gfortran version > 10
fpm build --flag '-fallow-argument-mismatch' 
```
According to your gfortran version, select and type the above corresponding command line, 
you will find your compiled results in the "./build" folder.

### Fpm test
```
# gfortran version < 10
fpm test

# gfortran version > 10
fpm test --flag '-fallow-argument-mismatch' 
```
According to your gfortran version, select and type the above corresponding command line, 
you can run the test program.

Or you copy the the executable program `example_fft` from the "./build" folder to the "./example" folder, 
then you type `./example_fft` to run it linking the "*.bin" files.

## example_fft
```fortran
program example_fft

  use fftpack, only: fft, ifft, czt, conv, xcorr, hilbert, filter, &
                     freq2ind, ind2freq, fftshift, ifftshift
  use forlab, only: disp, ones, loadbin, savebin

  implicit none

  integer(kind = 4) :: i, k
  real(kind = 8) :: toc_time
  real(kind = 8), dimension(:), allocatable :: x, y, w, signal, fsignal
  complex(kind = 8), dimension(:), allocatable :: cfft

  ! 1D Fast Fourier transform
  !===========================
  print *, "1D Fast Fourier transform:"

  x = [ 1., 1., 1., 1., 0., 0., 0., 0., 0. ]

  call disp(fft(x))

  ! 1D Fast Fourier transform using CZT
  !=====================================
  print *; print *, "1D Fast Fourier transform using CZT:"

  call disp(czt(x))

  print *; print *, "1D Inverse Fourier transform:"

  call disp(ifft(fft(x, 10)))

  ! Convolution
  !=============
  print *; print *, "Convolution:"

  call disp(conv(dble([ 1., 2., 3., 4., 5., 6. ]), dble([ 6., 7., 8., 1., 2., 4. ])))

  ! Correlation
  !=============
  print *; print *, "Correlation:"

  call disp(xcorr(dble([ 1., 2., 3., 4., 5., 6. ]), dble([ 6., 7., 8., 1., 2., 4. ])))

  ! Hilbert transform
  !===================
  print *; print *, "Hilbert transform:"

  call disp(hilbert(dble([ 1., 2., 3., 4., 5., 6. ])))

  ! Smooth data using convolution
  !===============================
  print *; print *, "Smooth data using convolution:"

  x = [ -2., 3., 5., -8., 8., 7., -8., -5., 2. ]
  k = 3
  y = conv(dble(x), ones(k))
  y = y(k/2+1:k/2+size(x)) / k

  call disp(y)

  ! Convert frequency to index
  !============================
  print *; print *, "Convert frequency to index:"

  print *, freq2ind(250., 500., 1200)

  ! Convert index to frequency
  !============================
  print *; print *, "Convert index to frequency:"

  print *, ind2freq(600, 500., 1200)

  ! Shift the Fourier transform
  !=============================
  print *; print *, "Shift the Fourier transform:"

  cfft = fft(x, 10)
  cfft = fftshift(cfft)

  call disp(cfft)

  ! Inverse shift the Fourier transform
  !=====================================
  print *; print *, "Inverse shift the Fourier transform:"

  cfft = ifftshift(cfft)

  call disp(cfft)

  ! Filter a signal
  !=================
  print *; print *, "Filter a real seismic signal between 1 and 10 Hz:"

  signal = loadbin("utils/signal.bin")
  fsignal = filter(signal, 100.0d0, 3, dble([ 1., 10. ]), 2, dble(0.5))

  call system("rm -rf utils/fsignal.bin")
  call savebin("utils/fsignal.bin", fsignal)
  print *, "Filtered signal saved in utils/fsignal.bin"

  print *
  stop
end program example_fft

```


## Link
[keurfonluu/FFTPack](https://github.com/keurfonluu/FFTPack)  
[keurfonluu/Forlab](https://github.com/keurfonluu/Forlab)
https://github.com/NCAR/ncl/issues/123
