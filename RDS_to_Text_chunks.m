rds_param
% Load data
load rds_bits_samples\PR2_log2.txt;
data = PR2_log2.';
clear PR2_log2 ; 

disp('RDS to text - selected services')
disp('PI, PTY, AF, RadioText, Time, Date');
bits_length = (length(data)-130);
disp('Reading information from RDS bits.');

sFlagBlockA=0;
sFlagBlockB=0;
sFlagBlockCa=0;
sFlagBlockCb=0;
sFlagBlockD=0;

% Syndroms
sA =  [1 1 1 1 0 1 1 0 0 0];
sB =  [1 1 1 1 0 1 0 1 0 0];
sCa = [1 0 0 1 0 1 1 1 0 0];
sCb = [1 1 1 1 0 0 1 1 0 0];
sD =  [1 0 0 1 0 1 1 0 0 0];

blockA=[];
blockB=[];
blockC=[];
blockD=[];

detected_block_counter=0;
while (loper < bits_length)
   syndrome_result = syndrome(loper, data, check);
   
   % block A
   if (syndrome_result == sA & sFlagBlockA == 0)
      blockA = data(loper:loper+25);
      sFlagBlockA=1;
      loper = loper + 26;
   end
   syndrome_result = syndrome(loper, data, check);
   % block B
   if (syndrome_result == sB & sFlagBlockA == 1 & sFlagBlockB == 0)
      blockB = data(loper:loper+25);
      sFlagBlockB=1;
      loper = loper + 26;
   end
   
   syndrome_result = syndrome(loper, data, check);
   % block Ca
   if (syndrome_result == sCa & sFlagBlockA == 1 & sFlagBlockB == 1 & sFlagBlockCa == 0)
      blockC = data(loper:loper+25);
      sFlagBlockCa=1;
      loper = loper + 26;
   end
   % block Cb
   if (syndrome_result == sCb & sFlagBlockA == 1 & sFlagBlockB == 1 & sFlagBlockCb == 0)
       blockC = data(loper:loper+25);
      sFlagBlockCb=1;
      loper = loper + 26;
   end
   
   syndrome_result = syndrome(loper, data, check);
   if (syndrome_result == sD & sFlagBlockA == 1 & sFlagBlockB == 1 & sFlagBlockCa == 1 & sFlagBlockD == 0)
      disp('dddd')
      blockD = data(loper:loper+25);
      sFlagBlockD=1;
      [text1, text2,AF,N,PIN,Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY] = rds_analysis_start_chunks(loper, blockA, blockB, blockC, blockD, text1, text2,AF,N,PIN, ...
                                                                                            Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY);           
      sFlagBlockA=0;
      sFlagBlockB=0;
      sFlagBlockC=0;
      sFlagBlockD=0;
      loper = loper + 26;
      detected_block_counter=detected_block_counter+1;
   end
   
   if (syndrome_result == sD & sFlagBlockA == 1 & sFlagBlockB == 1 & sFlagBlockCb == 1 & sFlagBlockD == 0)
      blockD = data(loper:loper+25);
      sFlagBlockD=1;
      [text1, text2,AF,N,PIN,Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY] = rds_analysis_start_chunks(loper, blockA, blockB, blockC, blockD, text1, text2,AF,N,PIN, ...
                                                                                            Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY);           
      sFlagBlockA=0;
      sFlagBlockB=0;
      sFlagBlockC=0;
      sFlagBlockD=0;
      loper = loper + 26;
      detected_block_counter=detected_block_counter+1;
   end
   loper = loper+1;                          
end

 detected_block_counter
