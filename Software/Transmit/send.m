 function send(message)
    message = "super dooper long test";
    Debugging = true;               % Disable debugging printouts
    ampDiff = 3/5;            % Difference between size of first and second peak (Elle change to 1)
    maxAmp = 1/(1+ampDiff+ampDiff*ampDiff+ampDiff*ampDiff*ampDiff);   % Total amplitude made by output x/(dont touch)
    sampleRate = 48000;             % sample rate (Elle change to 48000)
    bitRate = 2;                  % Bits sent every x seconds
    heightMult = 1/3;               % The multiplier creating the diffence between 1 and 0
    peakOne = 250;                  % frequency of first  peak
    peakTwo = 2250;                  % frequency of second peak
    peakThree = 4250;                  % frequency of second peak
    peakFour = 6250;
    oscillatorFreq = 0.25;             % Frequency of the oscillator
    trans = 1;


    % ==================================================================
    % Load huffmanCode
    % ==================================================================
    charMessage = char(message);

    stringstream = huffmanEncode(charMessage);

    if(Debugging)
        fprintf("huffman size: %i\n", length(char(stringstream)));
    end

    number = 4-mod(length(char(stringstream)),4);

    if(number<4)
        for i=1:number
            stringstream = stringstream+"0";
            if(Debugging)
                fprintf("added 0 to the end\n");
            end
        end
    end

    stream = char(stringstream);

    if(Debugging)
        fprintf("huffman size: %i\n", length(stream));
    end


    finalLength = ceil((length(stream)/4-1)*sampleRate*trans+length(stream)*sampleRate*bitRate/4);    % length of final output

    % ==================================================================
    % assigning arrays
    % ==================================================================

    rang = transpose(linspace(1,bitRate,sampleRate*bitRate));
    waveOne     = sin(2* pi * peakOne   * rang);
    if(Debugging)
        fprintf("Wave one complete\n");
    end
    waveTwo     = ampDiff*sin(2* pi * peakTwo * rang);
    if(Debugging)
        fprintf("Wave two complete\n");
    end
    waveThree   = ampDiff*ampDiff*sin(2* pi * peakThree * rang);
    if(Debugging)
        fprintf("Wave three complete\n");
    end
    waveFour    = ampDiff*ampDiff*ampDiff*sin(2* pi * peakFour  * rang);
    if(Debugging)
        fprintf("Wave four complete\n");
    end

    zzzz = (maxAmp*heightMult)*waveOne + (maxAmp*heightMult)*waveTwo + (maxAmp*heightMult)*waveThree + (maxAmp*heightMult)*waveFour;
    zzzo = (maxAmp*heightMult)*waveOne + (maxAmp*heightMult)*waveTwo + (maxAmp*heightMult)*waveThree + (maxAmp           )*waveFour;
    zzoz = (maxAmp*heightMult)*waveOne + (maxAmp*heightMult)*waveTwo + (maxAmp           )*waveThree + (maxAmp*heightMult)*waveFour;
    zzoo = (maxAmp*heightMult)*waveOne + (maxAmp*heightMult)*waveTwo + (maxAmp           )*waveThree + (maxAmp           )*waveFour;
    zozz = (maxAmp*heightMult)*waveOne + (maxAmp           )*waveTwo + (maxAmp*heightMult)*waveThree + (maxAmp*heightMult)*waveFour;
    zozo = (maxAmp*heightMult)*waveOne + (maxAmp           )*waveTwo + (maxAmp*heightMult)*waveThree + (maxAmp           )*waveFour;
    zooz = (maxAmp*heightMult)*waveOne + (maxAmp           )*waveTwo + (maxAmp           )*waveThree + (maxAmp*heightMult)*waveFour;
    zooo = (maxAmp*heightMult)*waveOne + (maxAmp           )*waveTwo + (maxAmp           )*waveThree + (maxAmp           )*waveFour;
    ozzz = (maxAmp           )*waveOne + (maxAmp*heightMult)*waveTwo + (maxAmp*heightMult)*waveThree + (maxAmp*heightMult)*waveFour;
    ozzo = (maxAmp           )*waveOne + (maxAmp*heightMult)*waveTwo + (maxAmp*heightMult)*waveThree + (maxAmp           )*waveFour;
    ozoz = (maxAmp           )*waveOne + (maxAmp*heightMult)*waveTwo + (maxAmp           )*waveThree + (maxAmp*heightMult)*waveFour;
    ozoo = (maxAmp           )*waveOne + (maxAmp*heightMult)*waveTwo + (maxAmp           )*waveThree + (maxAmp           )*waveFour;
    oozz = (maxAmp           )*waveOne + (maxAmp           )*waveTwo + (maxAmp*heightMult)*waveThree + (maxAmp*heightMult)*waveFour;
    oozo = (maxAmp           )*waveOne + (maxAmp           )*waveTwo + (maxAmp*heightMult)*waveThree + (maxAmp           )*waveFour;
    oooz = (maxAmp           )*waveOne + (maxAmp           )*waveTwo + (maxAmp           )*waveThree + (maxAmp*heightMult)*waveFour;
    oooo = (maxAmp           )*waveOne + (maxAmp           )*waveTwo + (maxAmp           )*waveThree + (maxAmp           )*waveFour;



    % ==================================================================
    % Defining transision arrays
    % ==================================================================

    peakOneTrans    = zeros(trans*sampleRate,1); % transitions from 0 - 1
    peakTwoTrans    = zeros(trans*sampleRate,1);
    peakThreeTrans  = zeros(trans*sampleRate,1);
    peakFourTrans   = zeros(trans*sampleRate,1);
    transLine = linspace(heightMult, 1, trans*sampleRate);
    for i=1:trans*sampleRate
        peakOneTrans(i)     = maxAmp*transLine(i)*waveOne(i);
        peakTwoTrans(i)     = maxAmp*transLine(i)*waveTwo(i);
        peakThreeTrans(i)   = maxAmp*transLine(i)*waveThree(i);
        peakFourTrans(i)    = maxAmp*transLine(i)*waveFour(i);
    end


    if(Debugging)
        fprintf("size: %i\n",length(zzzz));
    end

    % ==================================================================
    % Creating output
    % ==================================================================
    counter = 1;
    outputArray = []
    for i=1:4:length(stream)
        string = strcat(stream(i),stream(i+1),stream(i+2),stream(i+3));

        switch(string)
        case "0000"
            if(Debugging)
                fprintf("zzzz\n");
            end
            outputArray = [outputArray; zzzz];
        case "0001"
            if(Debugging)
                fprintf("zzzo\n");
            end
            outputArray = [outputArray; zzzo];
        case "0010"
            if(Debugging)
                fprintf("zzoz\n");
            end
            outputArray = [outputArray; zzoz];
        case "0011"
            if(Debugging)
                fprintf("zzoo\n");
            end
            outputArray = [outputArray; zzoo];
        case "0100"
            if(Debugging)
                fprintf("zozz\n");
            end
            outputArray = [outputArray; zozz];
        case "0101"
            if(Debugging)
                fprintf("zozo\n");
            end
            outputArray = [outputArray; zozo];
        case "0110"
            if(Debugging)
                fprintf("zooz\n");
            end
            outputArray = [outputArray; zooz];
        case "0111"
            if(Debugging)
                fprintf("zooo\n");
            end
            outputArray = [outputArray; zooo];
        case "1000"
            if(Debugging)
                fprintf("ozzz\n");
            end
            outputArray = [outputArray; ozzz];
        case "1001"
            if(Debugging)
                fprintf("ozzo\n");
            end
            outputArray = [outputArray; ozzo];
        case "1010"
            if(Debugging)
                fprintf("ozoz\n");
            end
            outputArray = [outputArray; ozoz];
        case "1011"
            if(Debugging)
                fprintf("ozoo\n");
            end
            outputArray = [outputArray; ozoo];
        case "1100"
            if(Debugging)
                fprintf("oozz\n");
            end
            outputArray = [outputArray; oozz];
        case "1101"
            if(Debugging)
                fprintf("oozo\n");
            end
            outputArray = [outputArray; oozo];
        case "1110"
            if(Debugging)
                fprintf("oooz\n");
            end
            outputArray = [outputArray; oooz];
        case "1111"
            if(Debugging)
                fprintf("oooo\n");
            end
            outputArray = [outputArray; oooo];

        otherwise
            fprintf("error\n");
        end

        if(i<length(stream)-4)
            transArray = zeros(sampleRate*trans,1);
            nextString = strcat(stream(i+4),stream(i+5),stream(i+6),stream(i+7));
            this = char(string);
            next = char(nextString);

            if(this(1)<next(1))
                transArray = peakOneTrans;
            elseif(this(1)==next(1))
                if(this(1)=='0')
                    transArray = heightMult*maxAmp*waveOne(1:sampleRate*trans);
                else
                    transArray = maxAmp*waveOne(1:sampleRate*trans);
                end
            else
                transArray = flip(peakOneTrans);
            end

            if(this(2)<next(2))
                transArray = transArray + peakTwoTrans;
            elseif(this(2)==next(2))
                if(this(2)=='0')
                    transArray = transArray + heightMult*maxAmp*waveTwo(1:sampleRate*trans);
                else
                    transArray = transArray + maxAmp*waveTwo(1:sampleRate*trans);
                end
            else
                transArray = transArray + flip(peakTwoTrans);
            end

            if(this(3)<next(3))
                transArray = transArray + peakThreeTrans;
            elseif(this(3)==next(3))
                if(this(3)=='0')
                    transArray = transArray + heightMult*maxAmp*waveThree(1:sampleRate*trans);
                else
                    transArray = transArray + maxAmp*waveThree(1:sampleRate*trans);
                end
            else
                transArray = transArray + flip(peakThreeTrans);
            end

            if(this(4)<next(4))
                transArray = transArray + peakFourTrans;
            elseif(this(4)==next(4))
                if(this(4)=='0')
                    transArray = transArray + heightMult*maxAmp*waveFour(1:sampleRate*trans);
                else
                    transArray = transArray + maxAmp*waveFour(1:sampleRate*trans);
                end
            else
                transArray = transArray + flip(peakFourTrans);
            end

            outputArray = [outputArray; transArray];
        end
        counter = counter+sampleRate*bitRate;


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
    % filtering noise away from 0Hz
    % ==================================================================

    % load("Filters/high16k100.mat");
    % finalOut = conv(finalOut, impresp);
    % finalOut = finalOut(1:finalLength);

    % ==================================================================
    % Adding a little bit more noise accross entire band
    % ==================================================================
    mu=0;
    sigma=1;
    x=sigma*randn(finalLength,1)+mu;
    finalOut = finalOut+0.015*x;

%     load("Filters/high16k8000.mat");
%     xx = conv(x, impresp);
%     xx = xx(1:finalLength);
%     finalOut = finalOut+xx;

    % ==================================================================
    % final oscillator
    % ==================================================================
    len = linspace(1,length(stream)*bitRate/2,finalLength);
    oscillator = (0.25*cos(2*pi*oscillatorFreq*len)+0.75)';
    finalOut = finalOut .* oscillator;
    % finalOut = oscillator;

    % ==================================================================
    % PLOTTING for this to work send "oa"
    % ==================================================================
    if(Debugging && false)
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

    X = fft(finalOut);

    plot(finalOut);


    if(Debugging)
        fprintf("Play time: %f\n",length(finalOut)/sampleRate);
    end
    
    audiowrite(char(strcat("../soundFiles/encoded_data.wav")),finalOut,sampleRate);
    sound(finalOut, sampleRate);
    
 end
