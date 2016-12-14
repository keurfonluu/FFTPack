program example_fft

  use fftpack, only: fft, ifft, czt, conv, xcorr, hilbert, filter, &
                     freq2ind, ind2freq
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
