function y = gethbyte(x,b)
    mask = bitshift(0x0000000F,(b*4));
    y = bitshift( bitand(x , mask), -b*4);
end