% RDS to text decoder

index=1
text1 = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
text2 = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
AF = [];    
N = 0;     
PIN = [0 0 0];
MJD = 0;
Y = 0;
M = 0;
Day = 0;
Hour = 0;
Minutes = 0;
LocalTimeOffset = 0;
PI = 0;
PTY = 0;

check = [ 1 0 0 0 0 0 0 0 0 0;
   0 1 0 0 0 0 0 0 0 0;
   0 0 1 0 0 0 0 0 0 0;
   0 0 0 1 0 0 0 0 0 0;
   0 0 0 0 1 0 0 0 0 0;
   0 0 0 0 0 1 0 0 0 0;
   0 0 0 0 0 0 1 0 0 0;
   0 0 0 0 0 0 0 1 0 0;
   0 0 0 0 0 0 0 0 1 0;
   0 0 0 0 0 0 0 0 0 1;
   1 0 1 1 0 1 1 1 0 0;
   0 1 0 1 1 0 1 1 1 0;
   0 0 1 0 1 1 0 1 1 1;
   1 0 1 0 0 0 0 1 1 1;
   1 1 1 0 0 1 1 1 1 1;
   1 1 0 0 0 1 0 0 1 1;
   1 1 0 1 0 1 0 1 0 1;
   1 1 0 1 1 1 0 1 1 0;
   0 1 1 0 1 1 1 0 1 1;
   1 0 0 0 0 0 0 0 0 1;
   1 1 1 1 0 1 1 1 0 0;
   0 1 1 1 1 0 1 1 1 0;
   0 0 1 1 1 1 0 1 1 1;
   1 0 1 0 1 0 0 1 1 1;
   1 1 1 0 0 0 1 1 1 1;
   1 1 0 0 0 1 1 0 1 1];


% Load data
load rds_bits_samples\PR2_log2.txt;
data = PR2_log2.';
clear PR2_log2 ; 

disp('RDS to text - selected services')
disp('PI, PTY, AF, RadioText, Time, Date');
bits_length = (length(data)-130);
disp('Reading information from RDS bits.');

% Syndroms
sA =  [1 1 1 1 0 1 1 0 0 0];
sB =  [1 1 1 1 0 1 0 1 0 0];
sCa = [1 0 0 1 0 1 1 1 0 0];
sCb = [1 1 1 1 0 0 1 1 0 0];
sD =  [1 0 0 1 0 1 1 0 0 0];

detected_block_counter=0;
while (index < bits_length)
   syndrome_result = syndrome(index, data, check);
   if (syndrome_result == sA)                             % block A
      syndrome_result = syndrome(index+26, data, check);
      if (syndrome_result == sB)                          % block B
         syndrome_result = syndrome (index + 52, data, check);
         if (syndrome_result == sCa)                      % block C
            syndrome_result = syndrome (index + 78, data, check);
            if (syndrome_result == sD)                    % block D
               [text1, text2,AF,N,PIN,Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY] = rds_analysis_start(index, data, text1, text2,AF,N,PIN, ...
                                                                                            Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY);           
               index = index + 103;  
               detected_block_counter=detected_block_counter+1;
            end
         elseif (syndrome_result == sCb)                  % block C'
            syndrome_result = syndrome (index + 78, data, check);
            if (syndrome_result == sD)                    % block D'
                [text1, text2,AF,N,PIN,Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY] = rds_analysis_start(index, data, text1, text2,AF,N,PIN, ...
                                                                                            Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY);
                index = index + 103;
                detected_block_counter=detected_block_counter+1;
            end
         end
      end                  
   end
   index = index + 1;                               
end

detected_block_counter
