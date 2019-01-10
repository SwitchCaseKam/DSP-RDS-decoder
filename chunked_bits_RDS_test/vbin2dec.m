function [ dec_1 ] = vbin2dec( vect )
% vbin2dec - function that convert binary vector to decimal number

    str = mat2str(vect);
    
    str = [str(2) str(4) str(6) str(8) str(10) str(12) str(14) str(16)];
    dec_1 = bin2dec(str);

end

