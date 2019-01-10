% Load data
load log_RDS_book_KRK.txt;
data = log_RDS_book_KRK.';
clear log_RDS_book_KRK ; 

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


index = 1;
% Syndroms
sA =  [1 1 1 1 0 1 1 0 0 0];
sB =  [1 1 1 1 0 1 0 1 0 0];
sCa = [1 0 0 1 0 1 1 1 0 0];
sCb = [1 1 1 1 0 0 1 1 0 0];
sD =  [1 0 0 1 0 1 1 0 0 0];

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

data;

len_data = length(data);
size_of_element = 100;
amount_of_elements = floor(len_data / size_of_element);
data = data(1:size_of_element*amount_of_elements);
length(data);
Out = mat2cell(data, 1, size_of_element*ones(1, amount_of_elements));


sFlagBlockA=0;
sFlagBlockB=0;
sFlagBlockCa=0;
sFlagBlockCb=0;
sFlagBlockD=0;

blockA=[];
blockB=[];
blockC=[];
blockD=[];

detected_block_counter=0;

amount_of_elements = amount_of_elements - 1
for i=1 : amount_of_elements
     
    out_data = Out{i};
    length_out_data = length(out_data);
    if (index >= length_out_data)
        index = 1;
    end
    while (index <= length_out_data)
        % block A
        syndrome_result = syndrome(index, out_data, check);
        if (syndrome_result == sA & sFlagBlockA == 0)
            sFlagBlockA=1;
            block_end = index+25;
            next_index = index;
            if (block_end <= length_out_data)
                blockA = out_data(index:index+25);
                next_index = index+25;
                index = next_index+1;
            else
                index_next_block = length_out_data - index;
                blockA = [out_data(index:length_out_data) Out{i+1}(1:(25 - index_next_block))];
                next_index = 25 - index_next_block; 
                out_data = [out_data Out{i+1}];
                index = next_index+1;
                break;
                
                
            end
         else
            out_data = [out_data Out{i+1}];
        end
            
            
            % block B
            syndrome_result = syndrome(index, out_data, check);
            if (syndrome_result == sB & sFlagBlockA == 1 & sFlagBlockB == 0)
                sFlagBlockB=1;
                block_end = index+25;
                next_index = index;
                if (block_end <= length_out_data)
                    blockB = out_data(index:index+25);
                    next_index = index+25;
                    index = next_index+1;
                else
                    index_next_block = length_out_data - index;
                    blockB = [out_data(index:length_out_data) Out{i+1}(1:(25 - index_next_block))];
                    next_index = 25 - index_next_block;
                    out_data = [out_data Out{i+1}];
                    index = next_index+1;
                    break;
                end
        else
            out_data = [out_data Out{i+1}];
        end
            

           index;
            syndrome_result = syndrome(index, out_data, check);
            % block Ca
            if (syndrome_result == sCa & sFlagBlockA == 1 & sFlagBlockB == 1 & sFlagBlockCa == 0)
                sFlagBlockCa=1;
                block_end = index+25;
                next_index = index;
                if (block_end <= length_out_data)
                    blockC = out_data(index:index+25);
                    next_index = index+25;
                    index = next_index+1;
                else
                    index_next_block = length_out_data - index;
                    blockC = [out_data(index:length_out_data) Out{i+1}(1:(25 - index_next_block))];
                    next_index = 25 - index_next_block; 
                    out_data = [out_data Out{i+1}];
                    index = next_index+1;
                    break;
                    
                end

              else
            out_data = [out_data Out{i+1}];
        end
            
            
            syndrome_result = syndrome(index, out_data, check);
            % block Cb
            if (syndrome_result == sCb & sFlagBlockA == 1 & sFlagBlockB == 1 & sFlagBlockCb == 0 )
                sFlagBlockCb=1;
                block_end = index+25;
                next_index = index;
                if (block_end <= length_out_data)
                    blockC = out_data(index:index+25);
                    next_index = index+25;
                    index = next_index+1;
                else
                    index_next_block = length_out_data - index;
                    blockC = [out_data(index:length_out_data) Out{i+1}(1:(25 - index_next_block))];
                    next_index = 25 - index_next_block; 
                    index = next_index+1;
                    break;
                    
                end

              else
            out_data = [out_data Out{i+1}];
        end
            
            
            %block D
           syndrome_result = syndrome(index, out_data, check);
           if (syndrome_result == sD & sFlagBlockA == 1 & sFlagBlockB == 1 & sFlagBlockCa == 1 & sFlagBlockD == 0)
                sFlagBlockD=1;
                block_end = index+25;
                next_index = index;
                if (block_end <= length_out_data)
                    blockD = out_data(index:index+25);
                    next_index = index+25;
                    index = next_index+1;
                else
                    index_next_block = length_out_data - index;
                    blockD = [out_data(index:length_out_data) Out{i+1}(1:(25 - index_next_block))];
                    next_index = 25 - index_next_block; 
                    out_data = [out_data Out{i+1}];
                    index = next_index+1;
                end
              [text1, text2,AF,N,PIN,Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY] = rds_analysis_start_chunks(index, blockA, blockB, blockC, blockD, text1, text2,AF,N,PIN, ...
                                                                                                    Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY);           
              sFlagBlockA=0;
              sFlagBlockB=0;
              sFlagBlockCa=0;
              sFlagBlockCb=0;
              sFlagBlockD=0;
              
              detected_block_counter=detected_block_counter+1;
           end
            
           %block D
           syndrome_result = syndrome(index, out_data, check);
           if (syndrome_result == sD & sFlagBlockA == 1 & sFlagBlockB == 1 & sFlagBlockCb == 1 & sFlagBlockD == 0)
                sFlagBlockD=1;
                block_end = index+25;
                next_index = index;
                if (block_end <= length_out_data)
                    blockD = out_data(index:index+25);
                    next_index = index+25;
                    index = next_index+1;
                else
                    index_next_block = length_out_data - index;
                    blockD = [out_data(index:length_out_data) Out{i+1}(1:(25 - index_next_block))];
                    next_index = 25 - index_next_block; 
                    out_data = [out_data Out{i+1}];
                    index = next_index+1;
                end
              [text1, text2,AF,N,PIN,Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY] = rds_analysis_start_chunks(index, blockA, blockB, blockC, blockD, text1, text2,AF,N,PIN, ...
                                                                                                    Hour,Minutes,LocalTimeOffset,Y,M,Day,PI,PTY);           
              sFlagBlockA=0;
              sFlagBlockB=0;
              sFlagBlockCa=0;
              sFlagBlockCb=0;
              sFlagBlockD=0;
              
              detected_block_counter=detected_block_counter+1;
           end
    
   index = index + 1;
   end
   i = i + 1;
end

detected_block_counter




