% Each textseg contains four chars -> determine what group it is
% place it at the correct position
%
% (c) 2001 Lieven Hollevoet, picmicro@hollie.tk

% Re-use of this code is hereby permitted, as long as
% my name and e-mail address are mentioned in the new
% version.


function [textA, textB] = locate_it(chars, text_seg, AB_flag, text1, text2)

first = (text_seg(1) * 8 + text_seg(2) * 4 + text_seg(3) * 2 + text_seg(4)) * 4 + 1;

if AB_flag == 0 
   text1(first:first+3) = chars;
   %fprintf('AB flag = 0\n');
else
   text2(first:first+3) = chars;
   %fprintf('AB flag = 1\n');
end

  
textA = text1;
textB = text2;

end
   
   