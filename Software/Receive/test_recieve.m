fname = '../soundFiles/test4.m4a';
[y,fs]=audioread(fname);
L = length(y);%50000;
y = y(1:L,1);

data_fft =fft(y);
%datashift = fftshift(data_fft);
%plot(abs(datashift(:,1)));
data_fft = data_fft(1:L/10);
plot(abs(data_fft(:,1)));

%plot(y);
player = audioplayer(y,fs);
%play(player);

