function receive(filename)
    filename = '../soundFiles/encoded_data.wav';
    Debugging = false;              % Disable debugging printouts
    ampDifference = 3/4;            % Difference between size of first and second peak (Elle change to 1)
    maxAmp = 2/(1+ampDifference);   % Total amplitude made by output x/(dont touch)
    sampleRate = 16000;             % sample rate (Elle change to 48000)
    bitRate = 1/2;                  % Bits sent every x seconds
    heightMult = 1/2;               % The multiplier creating the diffence between 1 and 0
    peakOne = 220;                  % frequency of first  peak
    peakTwo = 660;                  % frequency of second peak
    oscillatorFreq = 2;             % Frequency of the oscillator

    % ==================================================================
    % load the sound file and break into chunks
    % ==================================================================

    [y,sampleRate]=audioread(filename);
    len_bit_piece = sampleRate*bitRate;
    num_chunks = length(y)/len_bit_piece;
    y_split = reshape(y, len_bit_piece, num_chunks);
    
    % ==================================================================
    % loop over each chunk, calculate bandpower and classify
    % ==================================================================
    thresh1 = 0.0017;
    thresh2 = 0.0025;
    
    final = "";
    
    bp1 = 0;
    bp2 = 0;
    
    for i = 1:num_chunks
       sample =  y_split(:,i);
       bp1 = bandpower(sample, sampleRate, [170 270]); %for band centered at 220
       bp2 = bandpower(sample, sampleRate, [580 740]); %for band centered at 660
      
       if(bp1<=thresh1 && bp2<= thresh2)
           final = final + "00";
       elseif(bp1<=thresh1 && bp2>= thresh2)
           final = final + "01";
       elseif(bp1>=thresh1 && bp2<= thresh2)
           final = final + "10";
       else
           final = final + "11";
       end
    end

    message = huffmanDecode(char(final));
    fprintf(final+"\n");
    fprintf("Decoded Message: "+message+"\n");
    
end




