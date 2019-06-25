clc;
close all;

file = 'Whale_sound1.mp3';
[signal,Fs] = audioread(file);
signal=signal(:,1)';
Nsamps = length(signal);
t = (1/Fs)*(1:Nsamps) ; 
figure();
plot(t,signal)
title('Plot of signal')
pfft(signal,Fs)

integralsignal=cumsum(signal);
fc=10000;
kf=2*pi*0.1;
phase= 2.*pi.*fc.*t+kf.*integralsignal;

instFreq=diff(phase);


fmsignal=2*cos(phase);

figure();
plot(t,fmsignal)
title('Plot of frequency modulated signal')
pfft(fmsignal,Fs)




figure();
plot(t,phase)
title('Plot of phase')


figure();
plot(t(1:end-1),instFreq)
title('Plot of instant frequency(derive of phase)')


figure();
file = 'ses.mp3';
[channel,Fs1] = audioread(file);
channel=channel(:,1)';
Nsamps1 = length(channel);
t1 = (1/Fs1)*(1:Nsamps1);
channelextend=zeros(1,length(signal));
for i1 = 1:length(channel)
      channelextend(i1) =  channel(i1);
end
integralchannel=cumsum(channelextend);
kf1=2*pi*0.1;
fc1=14000;
fmchannel=0.5.*cos(2.*pi.*fc1.*t+kf1.*integralchannel);

plot(t,fmchannel)
title('channel fm')
pfft(fmchannel,Fs1)

figure();
fmsignalpluschannel=fmchannel+fmsignal;
plot(t,fmsignalpluschannel)
title('channel fm plus signal')
pfft(fmsignalpluschannel,Fs)


figure();
noisefmsignal = awgn(fmsignalpluschannel,35);
plot(t,noisefmsignal)
title('Plot of noisy FM signal')
pfft(noisefmsignal,Fs)


bandfmsignal=bandpass(noisefmsignal,[fc-2400  fc+2400],Fs);
figure();
plot(t,bandfmsignal)
title('Plot of noisy FM signal from bandpass')
pfft(bandfmsignal,Fs)


derivsignal=diff(bandfmsignal);
figure();
plot(t(1:end-1),derivsignal);
title('Plot of derived signal')
pfft(derivsignal(1:end-1),Fs)





dmfm=envelope(derivsignal)-2-kf;
figure();
plot(t(2:end),dmfm)
title('Plot of envelope of derived signal')
pfft(dmfm(1:end-1),Fs)

sound(dmfm,Fs)






