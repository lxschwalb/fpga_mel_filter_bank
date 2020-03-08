import numpy as np

def generate_hamming_shift_reg(n=512, a0=0.54):
	print('logic[15:0] shift_reg[N] = {', end = '')
	for i in range(int(n)):
		x = a0-(1-a0)*np.cos(2*np.pi*i/(n-1))
		x = round(2**14*x)
		print('16\'d' + str(int(x)), end = '')
		if(i!=n-1):
			print(', ', end = '')
		else:
			print('};')

def generate_filt_bank_shift_reg(n=512, sample_rate=20000, nfilt=40):
	print("logic[15:0] filt_shift_reg[N] = {", end = '')
	mel_banks(find_mel_pts(n=n,
						   sample_rate=sample_rate,
						   nfilt=nfilt),
			  n)

def find_mel_pts(n=512, nfilt=40, sample_rate=20000):
	low_freq_mel = 0
	high_freq_mel = (2595 * np.log10(1 + (sample_rate / 2) / 700))  # Convert Hz to Mel
	mel_points = np.linspace(low_freq_mel, high_freq_mel, nfilt + 2)  # Equally spaced in Mel scale
	hz_points = (700 * (10**(mel_points / 2595) - 1))  # Convert Mel to Hz
	bins = np.floor((n + 1) * hz_points / sample_rate)
	return(bins)

def mel_banks(bins, n):
	x = 0
	for i in range(1, len(bins)):
		size = int(bins[i]-bins[i-1])
		x = np.hstack([x, np.linspace(0, 1, size+1)[1:]])

	for i in range(1, len(x)):
		z = round(2**15*x[i])
		print("16'd" + str(int(z)), end = '')
		if(i!= n/2):
			print(', ', end = '')
		else:
			print('};')