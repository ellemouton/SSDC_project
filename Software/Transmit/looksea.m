% Specify the audio file you want to use:
fname = '../soundFiles/OceanWaves.wav';
%[y,fs]=audioread(fname);



%y = y(1:2000000,1);

data_fft =fft(yt);
data_fft = data_fft(1:62500*0.6);
plot(abs(data_fft(:,1)));
%datashift = fftshift(data_fft);
%plot(abs(datashift(:,1)));

% Display the sampling info and length
sz = size(y);
n  = sz(1);
%disp('File: %s\nSamples: %d\nTime   : %d s\n',fname,n,n/fs);

% If longer than 500,000 samples cut if down else things are too slow!
if (n>500000)
   n=500000;
end;

% create time stamps for graph
x = [0:1/fs:(n-1)/fs];

% Display the graph
figure; plot(x(1:1200),y(1:1200));

% Play the sea sound
player = audioplayer(yt,fs);
%play(player);
