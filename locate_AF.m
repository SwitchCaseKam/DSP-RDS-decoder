% Places AF values in Alternative_frequencies vector
% and number of frequencies in Num_of_AF

function [Alternative_frequencies, N] = locate_AF(Alternative_frequencies, afn1 , afn2, N)

af1 = 0;
af2 = 0;
if afn1 >= 224
    N = afn1 - 224;                      % Number of VHF Alternative Frequencies 
elseif afn1 <= 204 
    af1 = 87.5 + (afn1 * 0.1);           % VHF Carrier frequency  [Table 10 VHF code table]
end

if afn2 >= 224
    N = afn2 - 224;
elseif afn2 <= 204
    af2 = 87.5 + (afn2 * 0.1);
end

if (af1)
if isempty(find(Alternative_frequencies == af1))
    Alternative_frequencies = [Alternative_frequencies af1];   
end
end

if (af2)
if isempty(find(Alternative_frequencies == af2))
    Alternative_frequencies = [Alternative_frequencies af2];
end
end

end