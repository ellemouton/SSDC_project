function receive()
    filename = 'encoded_data.wav';
    bitRate = 2;                % Bits sent every x seconds
    transRate = 1;              % transition periods in seconds
    p1 = 500;                   % frequency of first  peak
    p2 = 1700;                  % frequency of second peak
    p3 = 2500;                  % frequency of third peak
    p4 = 3700;                  % frequency of fourth peak

    % ==================================================================
    % load the sound file and break into chunks
    % ==================================================================

    [y,sampleRate]=audioread(filename);
    len_bit_piece = sampleRate*bitRate;
    len_transition = sampleRate*transRate;
    num_chunks = ceil(length(y)/(len_bit_piece+len_transition));
    
    % ==================================================================
    % new array without transitions
    % ==================================================================
    
    y_cut = zeros(num_chunks*len_bit_piece,1);
    
    
    for i = 1:num_chunks
        if(i<num_chunks)
            new_index = ((i-1)*len_bit_piece)+1;
            old_index = ((i-1)*(len_bit_piece+len_transition))+1;
        else
            new_index = ((i-1)*len_bit_piece);
            old_index = ((i-1)*(len_bit_piece+len_transition));
        end
       
       y_cut(new_index:new_index+len_bit_piece-1) =  y(old_index: old_index+len_bit_piece-1);
    end
    
    y_split = reshape(y_cut, len_bit_piece, num_chunks);
    
    % ==================================================================
    % loop over each chunk, calculate bandpower and classify
    % ==================================================================
    thresh1 = 8;
    thresh2 = 1.6;
    thresh3 = 0.6;
    thresh4 = 0.1;
   
    final = "";
    
    bp1 = 0;
    bp2 = 0;
    bp3 = 0;
    bp4 = 0;
    
    for i = 1:num_chunks
       sample =  y_split(:,i);
       bp1 = bandpower(sample, sampleRate, [p1-400 p1+400])*10000;
       bp2 = bandpower(sample, sampleRate, [p2-400 p2+400])*10000;
       bp3 = bandpower(sample, sampleRate, [p3-400 p3+400])*10000;
       bp4 = bandpower(sample, sampleRate, [p4-400 p4+400])*10000;
       
       if(bp1<=thresh1)
           final = final + "0";
       else
           final = final + "1";
       end
       
       if(bp2<=thresh2)
           final = final + "0";
       else
           final = final + "1";
       end
       
       if(bp3<=thresh3)
           final = final + "0";
       else
           final = final + "1";
       end
       
       if(bp4<=thresh4)
           final = final + "0";
       else
           final = final + "1";
       end
       
    end
%     N = 10000;
%     yt =y_split(:,1);
%     freq_k = ([0:1:N-1])';
%     freq_hz = freq_k*(sampleRate/length(yt));
% 
%     data_fft4 =fft(yt);
%     data_fft4 = data_fft4(1:N);
%     plot(freq_hz,abs(data_fft4(:,1)));
    
    message = huffmanDecode(char(final));
    fprintf(final+"\n");
    fprintf("Decoded Message: "+message+"\n");
    
 end




