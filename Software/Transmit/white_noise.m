close all;

L=100000; %Sample length for the random signal
mu=0;
sigma=0.01;
x=sigma*randn(L,1)+mu;


%designfilt('lowpassfir', 'PassbandFrequency', 150, 'StopbandFrequency', 300, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', 48000);
%impresp = ans.Coefficients;
n = linspace(0,L-1,L);

x = conv(x, impresp);
x = x(1:L);

data_fft =fft(x);
%datashift = fftshift(data_fft);
figure; plot(abs(data_fft(:,1)));

% x = linspace(0,L,L);

% %create impulse response h[n]
% for i = 1:length(x)
%     if 0 <= x(i) & x(i) <= 100;
%         x(i) = 1;
%     else
%         x(i) = 0;
%     end
% end



w = cos(pi/220*n);
% 
% %Y = X.*w';
y = x.*w';
% plot(n,x);
% 
% 
% %plot(Y);
 player = audioplayer(x,8000);
 play(player);

 data_fft =fft(y);
 datashift = fftshift(data_fft);
 figure; plot(abs(datashift(:,1)));


%title(['White noise : \mu_x=',num2str(mu),' \sigma^2=',num2str(sigma^2)])
%xlabel('Samples')
%ylabel('Sample Values')

