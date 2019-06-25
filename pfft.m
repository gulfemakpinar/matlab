function   pfft(signal,Fs)
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
Nsamps = length(signal);

x_fft = abs(fft(signal));                            % Retain Magnitude
norm_x_fft=x_fft/Nsamps;                 % Normalization of Magnitude
norm_x_fft = norm_x_fft(1:Nsamps/2);   % Discard Half of Points (negative freq. components)
f = Fs*(0:Nsamps/2-1)/Nsamps ;              % Prepare freq data for plot
figure();
plot(f,norm_x_fft)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('One-Sided Spectrum')
end

