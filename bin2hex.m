function hexDecimal = bin2hex (vect)

binary = mat2str(vect);

binary = [binary(2) binary(4) binary(6) binary(8) binary(10) binary(12) binary(14) binary(16) binary(18) binary(20) ...
            binary(22) binary(24) binary(26) binary(28) binary(30) binary(32)];
hexDecimal = '';
lengthOfBin = length(binary);

while (lengthOfBin >= 4) % hex is 4 bit per char
	lengthOfBin = lengthOfBin - 4; 
end
    
if (lengthOfBin ~= 0)
	zeroesToAppend = 4 - lengthOfBin; 
else
    zeroesToAppend = 0;
end

for i = 1:zeroesToAppend
	binary = strcat('0', binary);
end

for i = 1:4:length(binary)
	hexDecimal = strcat(hexDecimal, dec2hex(bin2dec(binary(i:i+3))));
end

end