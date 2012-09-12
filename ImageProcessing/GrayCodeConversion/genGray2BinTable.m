% gray to binary lookup table generator

function gray2binLookUp =  genGray2BinTable()
    gray2binLookUp = grayToBinary(uint16([0:1:(2^16)-1]));
end