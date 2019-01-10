function [ dec_1 ] = vbin2dec24( vect )
% vbin2dec - function that convert binary vector to decimal number

    str = mat2str(vect);
    
    str = [str(2) str(4) str(6) str(8) str(10) str(12) str(14) str(16) str(18) str(20) str(22) str(24) str(26) ...
          str(28) str(30) str(32) str(34) str(36) str(38) str(40) str(42) str(44) str(46) str(48)];
    dec_1 = bin2dec(str);

end