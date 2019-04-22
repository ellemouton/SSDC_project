close all;

L=1000000; %Sample length for the random signal
fs = 48000;%44100; 
n = linspace(0,L-1,L);

%--------------------carriers---------------------
w1 = (cos(pi/40*n))';
w2 = (cos(pi/90*n))';
w3 = (cos(pi/200*n))';

%w = w1+w2+w3;
%w = w1.*w2;
w = w2;

%---------------------noise-----------------------
mu=0;
sigma=1;
x=sigma*randn(L,1)+mu;

%------------------Bandlimit the noise------------
%designfilt('lowpassfir', 'PassbandFrequency', 150, 'StopbandFrequency', 200, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', 48000);
%impresp = ans.Coefficients;
noise = conv(x,impresp); % bandlimit the noise
noise = noise(1:L);

%------------------Build final signal------------
y1 = (noise.*w1);%+(noise.*w3);
%y2 = (noise.*w2);
y3 = (noise.*w3);

y_t = [y1;y3];

n = linspace(0,(length(y_t))-1,length(y_t));
c = (cos(pi/100000*n)+1.5)';
y = y_t.*c;

%------------------FFT---------------------------
data_fft =fft(y);
%datashift = fftshift(data_fft);
%plot(abs(datashift(:,1)));
data_fft = data_fft(1:L/10);
plot(abs(data_fft(:,1)));

%------------------Play dem tunes----------------
player = audioplayer(y,fs);
play(player);
