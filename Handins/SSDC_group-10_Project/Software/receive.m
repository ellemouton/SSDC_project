function receive()
    filename = '../Output/encoded_data.wav';  %file to read audio from 
    bitRate = 2;                    % four Bits sent every x seconds
    transRate = 1;                  % transition periods in seconds
    
    % ==================================================================
    % define the frequencies that the bands will be centered around
    % ==================================================================
    
    p1 = 500;                       % frequency of first  peak
    p2 = 1700;                      % frequency of second peak
    p3 = 2500;                      % frequency of third peak
    p4 = 3700;                      % frequency of fourth peak

    % ==================================================================
    % load the sound file 
    % ==================================================================

    [y,sampleRate]=audioread(filename);      %load audio into array y 
    len_bit_piece = sampleRate*bitRate;      %length of time that each group of 4 bits will be sent for
    len_transition = sampleRate*transRate;   %length of time that each transition period will be
    num_chunks = ceil(length(y)/(len_bit_piece+len_transition)); % number of 4 bit groups that are beign received
    
    % ==================================================================
    % create a new array, y_cut, that will not include the transition
    % periods.
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
    
    % ====================================================================
    % Reshape the y_cut array so that it is a 2D array where every column 
    % represents a new data segment (where a new set of 4 bits is encoded)
    % ====================================================================
    
    y_split = reshape(y_cut, len_bit_piece, num_chunks);
    
    % ====================================================================
    % loop over each chunk, calculate the bandpower in all the predefined 
    % frequency bands and classify each band based on the thresholds
    % ====================================================================
    
    thresh1 = 8; thresh2 = 1.6; thresh3 = 0.6; thresh4 = 0.1;
   
    final = "";
    
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
    
    % ============================================================
    % pass the final bitstream to the huffman decoding algorithm
    % to get the decoded message back
    % ============================================================
    
    message = huffmanDecode(char(final));
    fprintf(final+"\n");
    fprintf("Decoded Message: "+message+"\n");
    
 end




