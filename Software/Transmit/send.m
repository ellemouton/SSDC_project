function send(message)
    Debugging = true;               % Disable debugging printouts
    ampDifference = 3/4;            % Difference between size of first and second peak (Elle change to 1)
    maxAmp = 2/(1+ampDifference);   % Total amplitude made by output x/(dont touch)
    sampleRate = 16000;             % sample rate (Elle change to 48000)
    bitRate = 1/2;                  % Bits sent every x seconds
    heightMult = 1/2;               % The multiplier creating the diffence between 1 and 0
    peakOne = 220;                  % frequency of first  peak
    peakTwo = 660;                  % frequency of second peak
    oscillatorFreq = 2;             % Frequency of the oscillator

    syms t
    signal(t) = cos(2*3.14159*t);

    % ==================================================================
    % Load huffmanCode
    % ==================================================================
    charMessage = char(message);

    stringstream = huffmanEncode(charMessage);

    if(mod(length(char(stringstream)),2)==1)
        stringstream = stringstream+"0";
        if(Debugging)
            fprintf("added 0 to the end\n");
        end
    end

    stream = char(stringstream);

    if(Debugging)
        fprintf("huffman size: %i\n", length(stream));
    end


    finalLength = ceil(length(stream)*sampleRate*bitRate/2);    % length of final output

    % ==================================================================
    % assigning arrays
    % ==================================================================

    rang = linspace(1,bitRate,sampleRate*bitRate);
    waveOne = signal(peakOne*rang);
    waveTwo = signal(peakTwo *rang);

    zz = (maxAmp*heightMult)*waveOne + (maxAmp*ampDifference*heightMult)*waveTwo;
    zo = (maxAmp*heightMult)*waveOne + (maxAmp*ampDifference)*waveTwo;
    oz = (maxAmp)*waveOne + (maxAmp*ampDifference*heightMult)*waveTwo;
    oo = (maxAmp)*waveOne + (maxAmp*ampDifference)*waveTwo;

    if(Debugging)
        fprintf("size: %i\n",length(zz));
    end

    % ==================================================================
    % Creating output
    % ==================================================================
    outputArray = zeros(finalLength,1);
    counter = 1;
    for i=1:2:length(stream)
        string = strcat(stream(i),stream(i+1));

        switch(string)
        case "00"
            if(Debugging)
                fprintf("zz\n");
            end
            outputArray(counter:counter+sampleRate*bitRate-1) = zz;
            counter = counter+sampleRate*bitRate;

        case "01"
            if(Debugging)
                fprintf("zo\n");
            end
            outputArray(counter:counter+sampleRate*bitRate-1) = zo;
            counter = counter+sampleRate*bitRate;

        case "10"
            if(Debugging)
                fprintf("oz\n");
            end
            outputArray(counter:counter+sampleRate*bitRate-1) = oz;
            counter = counter+sampleRate*bitRate;

        case "11"
            if(Debugging)
                fprintf("oo\n");
            end
            outputArray(counter:counter+sampleRate*bitRate-1) = oo;
            counter = counter+sampleRate*bitRate;

        otherwise
            fprintf("error\n");
        end
    end

    if(Debugging)
        fprintf("size of output: %i\n", length(outputArray));
    end

    % ==================================================================
    % convolving with noise
    % ==================================================================
    noise = noise_bubble(finalLength);

    if(Debugging)
        fprintf("made noise.\n");
    end
    finalOut = outputArray .* noise;

    % ==================================================================
    % Adding a little bit more noise accross entire band
    % ==================================================================
    mu=0;
    sigma=1;
    x=sigma*randn(finalLength,1)+mu;
    finalOut = finalOut+0.015*x;

    % ==================================================================
    % final oscillator
    % ==================================================================
    len = linspace(1,length(stream)*bitRate/2,finalLength);
    oscillator = (0.25*cos(2*pi*oscillatorFreq*len/sampleRate)+0.75)';
    finalOut = finalOut .* oscillator;

    % ==================================================================
    % PLOTTING for this to work send "oa"
    % ==================================================================
    if(Debugging)
        fprintf("plotting.\n");
        subplot(4,1,1);
        y = finalOut(1:bitRate*sampleRate);
        Y = fft(y);
        plot(real(Y));
        title("Zero Zero");
        ylim([-75 75]);

        subplot(4,1,2);
        y = finalOut(bitRate*sampleRate+1:bitRate*sampleRate*2);
        Y = fft(y);
        plot(real(Y));
        title("One One");
        ylim([-75 75]);

        subplot(4,1,3);
        y = finalOut(bitRate*sampleRate*3+1:bitRate*sampleRate*4);
        Y = fft(y);
        plot(real(Y));
        title("One Zero");
        ylim([-75 75]);

        subplot(4,1,4);
        y = finalOut(bitRate*sampleRate*4+1:bitRate*sampleRate*5);
        Y = fft(y);
        plot(real(Y));
        title("Zero One");
        ylim([-75 75]);
    end

    sound(finalOut, sampleRate);
end