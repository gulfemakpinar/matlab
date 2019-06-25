clc;
close all;

file = 'Whale_sound1.mp3';
[signal,Fs] = audioread(file);
signal=signal(:,1)';
Nsamps = length(signal);

sound(signal,Fs)

%Plot Sound File in Time Domain
t = (1/Fs)*(1:Nsamps) ;   
figure();
subplot(2,1,1)
plot(t,signal)
xlabel('Time (s)');
ylabel('Amplitude');
title('Time Domain');
A=abs(min(signal));

% Fourier Transform (One-Sided Spectrum)
Nsamps = length(signal);

x_fft = abs(fft(signal));                            % Retain Magnitude
norm_x_fft=x_fft/Nsamps;                 % Normalization of Magnitude
norm_x_fft = norm_x_fft(1:Nsamps/2);     % Discard Half of Points (negative freq. components)
f = Fs*(0:Nsamps/2-1)/Nsamps;               % Prepare freq data for plot




%Plot Sound File in Frequency Domain
subplot(2,1,2)
plot(f,norm_x_fft)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('One-Sided Spectrum of Signal')
xlim([0 1000]);




signalpluscarrier=signal+A;
figure();

subplot(2,1,1)
plot(t,signalpluscarrier)
xlabel('Time (s)');
ylabel('Amplitude');
title('Time Domain');

% Fourier Transform (One-Sided Spectrum)
Nsamps = length(signalpluscarrier);

x_fft = abs(fft(signalpluscarrier));                            % Retain Magnitude
norm_x_fft=x_fft/Nsamps;                 % Normalization of Magnitude
norm_x_fft = norm_x_fft(1:Nsamps/2);     % Discard Half of Points (negative freq. components)
f = Fs*(0:Nsamps/2-1)/Nsamps;               % Prepare freq data for plot

%Plot Sound File in Frequency Domain
subplot(2,1,2)
plot(f,norm_x_fft)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('One-Sided Spectrum of m(t)+A')
xlim([0 1000]);

modulatedsignal=zeros(1,length(signalpluscarrier));
for i = 1:length(signalpluscarrier)
      modulatedsignal(i) =  signalpluscarrier(i).*cos(2*pi.*10000.*i./Fs);
end
%sound(modulatedsignal,Fs)
figure();
subplot(2,1,1)
plot(t,modulatedsignal)
xlabel('Time (s)');
ylabel('Amplitude');
title('Time Domain');

% Fourier Transform (One-Sided Spectrum)
Nsamps = length(modulatedsignal);

x_fft = abs(fft(modulatedsignal));                            % Retain Magnitude
norm_x_fft=x_fft/Nsamps;                 % Normalization of Magnitude
norm_x_fft = norm_x_fft(1:Nsamps/2);     % Discard Half of Points (negative freq. components)
f = Fs*(0:Nsamps/2-1)/Nsamps;               % Prepare freq data for plot




%Plot Sound File in Frequency Domain
subplot(2,1,2)
plot(f,norm_x_fft)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('One-Sided Spectrum of Modulated Signal')
xlim([0 15000]);








figure();
noiseSignal = awgn(modulatedsignal,10);
%sound(y,Fs);
subplot(2,1,1)
plot(t,noiseSignal)
xlabel('Time (s)');
ylabel('Amplitude');
title('Time Domain');


subplot(2,1,2)

% Fourier Transform (One-Sided Spectrum)
Nsamps = length(noiseSignal);
x_fft = abs(fft(noiseSignal));                            % Retain Magnitude
norm_x_fft=x_fft/Nsamps;                 % Normalization of Magnitude
norm_x_fft = norm_x_fft(1:Nsamps/2);     % Discard Half of Points (negative freq. components)
f = Fs*(0:Nsamps/2-1)/Nsamps;               % Prepare freq data for plot

plot(f,norm_x_fft)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('One-Sided Spectrum Adding Noise')
xlim([0 15000]);

file1 = 'ses.mp3';
[channel,Fs1] = audioread(file1);
channel=channel(:,1)';
Nsamps1 = length(channel);
modulatedchannel=zeros(1,length(signal));
for i1 = 1:length(channel)
      modulatedchannel(i1) =  5*channel(i1).*cos(2*pi.*10000.*i1./Fs1);
end
figure();
noisesignalchannel = noiseSignal+modulatedchannel;
%sound(y,Fs);
subplot(2,1,1)
plot(t,noisesignalchannel)
xlabel('Time (s)');
ylabel('Amplitude');
title('Time Domain');


subplot(2,1,2)

% Fourier Transform (One-Sided Spectrum)
Nsamps = length(noisesignalchannel);
x_fft = abs(fft(noisesignalchannel));                            % Retain Magnitude
norm_x_fft=x_fft/Nsamps;                 % Normalization of Magnitude
norm_x_fft = norm_x_fft(1:Nsamps/2);     % Discard Half of Points (negative freq. components)
f = Fs*(0:Nsamps/2-1)/Nsamps;               % Prepare freq data for plot

plot(f,norm_x_fft)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('One-Sided Spectrum Adding Interference')
xlim([0 15000]);

demodulatedsignal=zeros(1,length(noisesignalchannel));
for i2 = 1:length(noisesignalchannel)
      demodulatedsignal(i2) =  5*noisesignalchannel(i2).*cos(2*pi.*10000.*i2./Fs);
end
figure();
subplot(2,1,1)
plot(t,demodulatedsignal)
xlabel('Time (s)');
ylabel('Amplitude');
title('Time Domain');

% Fourier Transform (One-Sided Spectrum)
Nsamps = length(demodulatedsignal);

x_fft = abs(fft(demodulatedsignal));                            % Retain Magnitude
norm_x_fft=x_fft/Nsamps;                 % Normalization of Magnitude
norm_x_fft = norm_x_fft(1:Nsamps/2);     % Discard Half of Points (negative freq. components)
f = Fs*(0:Nsamps/2-1)/Nsamps;               % Prepare freq data for plot




%Plot Sound File in Frequency Domain
subplot(2,1,2)
plot(f,norm_x_fft)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('One-Sided Spectrum of Demodulated Signal')
%%xlim([0 20000]);

filteredsignal=filter(Hd,demodulatedsignal);
sound(filteredsignal,Fs)
figure();
subplot(2,1,1)
plot(t,filteredsignal)
xlabel('Time (s)');
ylabel('Amplitude');
title('Time Domain');

% Fourier Transform (One-Sided Spectrum)
Nsamps = length(filteredsignal);

x_fft = abs(fft(filteredsignal));                            % Retain Magnitude
norm_x_fft=x_fft/Nsamps;                 % Normalization of Magnitude
norm_x_fft = norm_x_fft(1:Nsamps/2);     % Discard Half of Points (negative freq. components)
f = Fs*(0:Nsamps/2-1)/Nsamps;               % Prepare freq data for plot




%Plot Sound File in Frequency Domain
subplot(2,1,2)
plot(f,norm_x_fft)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('One-Sided Spectrum of Filtered Signal')
xlim([0 15000]);

