% Do the actual processing. 
% If you want to en/disable the intermediate output of the name, text1 and text2
% then you can (un)comment the last 5 lines of this file
%
% (c) 2001 Lieven Hollevoet, picmicro@hollie.tk

% Re-use of this code is hereby permitted, as long as
% my name and e-mail address are mentioned in the new
% version.

function [text1, text2, AF, N, PIN, Hour, Minutes,LocalTimeOffset,Y,M,D,PI,PTY] = rds_analysis_start_chunks(index, blockA, blockB, blockC, blockD, text1, text2, AF, N, PIN, Hour, Minutes, LocalTimeOffset, Y, M, D, PI, PTY)
	groupType = blockB(1:5);   % GT - Group Type

	if (groupType(1:4) == [0 0 0 0]) 			   % Group 0A, 0B
		PI = bin2hex(blockA(1:16));                % PI 
		PTY = vbin2dec([0 0 0 blockB(7:11)]);      % PTY - Programme Type code
	   if groupType(5) == 0      				% Grupa 0A   
		   alternative_frequences = [vbin2dec(blockC(1:8)) vbin2dec(blockC(9:16))]; % alternative frequences
		   [AF, N] = locate_AF(AF,alternative_frequences(1), alternative_frequences(2), N);
	   end
	   
	elseif (groupType(1:4) == [0 0 0 1])               % Group 1A, 1B
		Day = vbin2dec([0 0 0 blockD(1:5)]);
		Hours = vbin2dec([0 0 0 blockD(6:10)]);
		Minute = vbin2dec([0 0 blockD(11:16)]);
		PIN =[Day Hours Minute];						% PIN - Programme Item Number
			
	elseif (groupType(1:4) == [ 0 0 1 0 ])               % Groupa 2A, 2B
	   text_seg = blockB(13:16);						% Text segement adddress code
	   AB_flag = blockB(12);							% Text A/B flag
	   %chars = [vbin2char(blockC(1:8)) vbin2char(blockC(9:16) vbin2char(blockD(1:8)) vbin2char(blockD(9:16)];
   
       char_1 = vbin2char(blockC(1:8));
       char_2 = vbin2char(blockC(9:16));
       char_3 = vbin2char(blockD(1:8));
       char_4 = vbin2char(blockD(9:16));

       chars = [char_1 char_2 char_3 char_4];
       [text1 text2] = locate_it(chars, text_seg, AB_flag, text1, text2);

	elseif (groupType == [0 1 0 0 0])                					% Group 4A Clock-time & date
	   MJD = vbin2dec24([0 0 0 0 0 0 0 blockB(15:16) blockC(1:15)]);    % Modified Julian Day code
	   % MJD to YYYY:MM:DD
	   Y = fix((MJD-15078.2)/365.25);
	   M =  fix((MJD - 14956.1 - fix((Y*365.25)))/30.6001);
	   D = MJD - 14956 - fix((Y*365.25)) - fix((M*30.6001));
	   if M == 14 || M == 15
		   K = 1;
	   else
		   K = 0;
	   end
	   Y = Y+K;
	   M = M-1 - (K*12);
	   %time
	   Hour = vbin2dec([0 0 0 blockC(16) blockD(1:4)]);
	   Minutes = vbin2dec([0 0 blockD(5:10)]);
	   LocalTimeOffset = (vbin2dec([0 0 0 blockD(12:16)]))/2;   % LocalTimeOffset
	   end
	  
	show_RDS_details(groupType,PI,PTY,AF,N,text1,text2,Hour,Minutes,LocalTimeOffset,Y,M,D,PIN);
end
   