% Specify the audio file you want to use:
fname = '../soundFiles/encoded_data.wav';
[y,fs]=audioread(fname);

y = y(1:2000000,1);

n=500000;

L = 150000;%125000;
freq_k = ([0:1:L-1])';
freq_hz = freq_k*(fs/length(y));

data_fft =fft(y);
data_fft = data_fft(1:L);
plot(freq_hz,abs(data_fft(:,1)));
xlabel("Frequency [Hz]");
ylabel("Magnitude");

% create time stamps for graph
x = [0:1/fs:(n-1)/fs];

% Display the graph
%figure; plot(x,y(1:n));
%xlabel("Time [s]");
%ylabel("Magnitude");

% Play the sea sound
player = audioplayer(y,fs);
%play(player);

print(gcf, "-dpng", "encoded_waves");
