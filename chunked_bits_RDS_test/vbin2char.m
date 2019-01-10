% Convert binary vector to char
%
% (c) 2001 Lieven Hollevoet, picmicro@hollie.tk

% Re-use of this code is hereby permitted, as long as
% my name and e-mail address are mentioned in the new
% version.

function char_1 = vbin2char(vect)

    str = mat2str(vect);

    str = [str(2) str(4) str(6) str(8) str(10) str(12) str(14) str(16)];
    char_1 = char(bin2dec(str));

end



