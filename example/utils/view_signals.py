# -*- coding: utf-8 -*-
#==============================================================================
# view_signals.py
#------------------------------------------------------------------------------
# view_signals
#
# Created by
#       Keurfon Luu <keurfon.luu@mines-paristech.fr>
#       MINES ParisTech - Centre de Géosciences
#       PSL - Research University
#
# Last updated
#       2016-12-14 16:40
#==============================================================================

# Required modules
#==================
import numpy as np
import matplotlib.pyplot as plt

# Parameters
#============
fs = 1e2

# Import signals
#================
signal = np.fromfile("signal.bin", "float32")
fsignal = np.fromfile("fsignal.bin", "float64")

# Define axis
#=============
nt = len(signal)
at = np.linspace(0, nt/fs, nt)
af = np.linspace(0, fs, nt)

# Plot signals
#==============
fig = plt.figure(figsize = (12, 10), facecolor = "white")
fig.patch.set_alpha(0.)
ax1 = fig.add_subplot(2, 1, 1)
ax2 = fig.add_subplot(2, 1, 2)
ax1.patch.set_alpha(1.)
ax2.patch.set_alpha(1.)

ax1.plot(at, signal, color = "black", label = "Signal")
ax1.plot(at, fsignal, color = "red", label = "Filtered")
ax1.set_xlabel("Time (s)")
ax1.set_ylabel("Amplitude")
ax1.set_xlim(0, np.max(at))
ax1.grid(True)
ax1.legend()

ax2.semilogy(af[:int(nt/2)], np.abs(np.fft.fft(signal))[:int(nt/2)], color = "black", label = "Signal")
ax2.semilogy(af[:int(nt/2)], np.abs(np.fft.fft(fsignal))[:int(nt/2)], color = "red", label = "Filtered")
ax2.set_xlabel("Frequency (Hz)")
ax2.set_ylabel("Amplitude")
ax2.grid(True)
ax2.legend()