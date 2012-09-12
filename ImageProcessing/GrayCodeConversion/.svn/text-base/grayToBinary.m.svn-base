% unsigned int grayToBinary(unsigned int num)
% {
%     unsigned int numBits = 8 * sizeof(num);
%     unsigned int shift;
%     for (shift = 1; shift < numBits; shift *= 2)
%     {
%         num ^= num >> shift;
%     }
%     return num;
% }

function binNumber = grayToBinary(grayNumber)
    numBits = 16; % for unsigned 16 bit int
    num = grayNumber;
    shift = 1;
    
    for (ii = 1:sqrt(numBits))
        num = bitxor(num,bitsrl(num,shift));
        shift = shift*2;
    end
    binNumber = num;
end