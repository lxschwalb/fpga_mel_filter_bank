# fpga_mel_filter_bank
System Verilog implementation of Mel Filter Bank using the AXI Stream protocol. It has only been tested in simulation and not deployed on hardware yet.

The module has 3 assignable parameters. N sets the frame length, STRIDE sets the stride length and OUT_WIDTH sets the output width. N and STRIDE both have to be powers of 2, and OUT_WIDTH must be a factor of 40.

When $N$ is set to something other than 512, some changes have to be made in the code. The FFT IP has to be specified a new frame length, which can be done in Vivado with a GUI by double clicking on the FFT module. There are two shift registers that also have to be redefined, one in the hamming module, and one in the filter_bank module. To generate the new shift registers, run the python functions named generate_hamming_shift_reg() and generate_filt_bank_shift_reg() and copy their output into the places indicated in the modules.

If a Hamming window with an a_0 other than 0.54 is to be used, the generate_hamming_shift_reg() python function must be run again to generate the relevant shift register.

If a sampling rate other than 20 kHz is to be used, the generate_filt_bank_shift_reg() must be run again, because the locations of the Mel filter banks rely on the sampling rate.

Design considerations:
The pre-emphasis filter could cause overflow if there are very loud very high frequencies present in the audio signal. Specifically, it causes overflow when 2 consecutive samples have opposite signs and are greater than about half the maximum amplitude. If the module is to be used in situations where loud high frequencies are expected, we recommend just reducing or disabling the pre-emphasis filter. This can be done by changing the filt value in the prepare_input module. Setting it to 0 disables the filter.

Asynchronous reset of of the shift registers containing the Hamming window coefficients and the Mel filter banks is very expensive in hardware, therefore it is currently disabled. If the ability to asynchronously reset these shift registers is required, just uncomment the lines indicated in the hamming and filter_bank modules.
