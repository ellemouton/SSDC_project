function y=noise_bubble(len)

    mu=0;
    sigma=1;
    x=sigma*randn(len,1)+mu;

    % load("Filters/EllesFitler48k.mat");
    load("Filters/lowpass48k900.mat");

    y=conv(x,impresp);

    y = y(1:len);

end
