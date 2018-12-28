rds_param
% Load data
load rds_bits_samples\PR2_log1.txt;
data = PR2_log1.';
clear PR2_log1 ; 

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

while (loper < bits_length)
   syndrome_result = syndrome(loper, data, check);
   if (syndrome_result == sA)                             % block A
      syndrome_result = syndrome(loper+26, data, check);
      if (syndrome_result == sB)                          % block B
         syndrome_result = syndrome (loper + 52, data, check);
         if (syndrome_result == sCa)                      % block C
            syndrome_result = syndrome (loper + 78, data, check);
            if (syndrome_result == sD)                    % block D
               [text1, text2,AF,N,PIN,Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY] = rds_analysis_start(loper, data, text1, text2,AF,N,PIN, ...
                                                                                            Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY);           
               loper = loper + 103;                 
            end
         elseif (syndrome_result == sCb)                  % block C'
            syndrome_result = syndrome (loper + 78, data, check);
            if (syndrome_result == sD)                    % block D'
                [text1, text2,AF,N,PIN,Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY] = rds_analysis_start(loper, data, text1, text2,AF,N,PIN, ...
                                                                                            Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY);
                loper = loper + 103;
            end
         end
      end                  
   end
   loper = loper + 1;                               
end
