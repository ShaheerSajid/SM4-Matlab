%define system paramter
FK = [0xa3b1bac6 0x56aa3350 0x677d9197 0xb27022dc];
%define fixed paramter
CK = [0x00070e15 0x1c232a31 0x383f464d 0x545b6269 0x70777e85 0x8c939aa1 0xa8afb6bd 0xc4cbd2d9 0xe0e7eef5 0xfc030a11 0x181f262d 0x343b4249 0x50575e65 0x6c737a81 0x888f969d 0xa4abb2b9 0xc0c7ced5 0xdce3eaf1 0xf8ff060d 0x141b2229 0x30373e45 0x4c535a61 0x686f767d 0x848b9299 0xa0a7aeb5 0xbcc3cad1 0xd8dfe6ed 0xf4fb0209 0x10171e25 0x2c333a41 0x484f565d 0x646b7279];
%define cypher key
MK = [0x01234567 0x89ABCDEF 0xFEDCBA98 0x76543210];
%define input data
DT = [0x01234567 0x89ABCDEF 0xFEDCBA98 0x76543210];


%caclulate first 4 Ks
K = zeros(1,36);
K(1:4) = bitxor(MK,FK);
%calculate round keys
for i = 1:32
   tau = sbox( bitxor(bitxor(K(i+1),K(i+2)),bitxor(K(i+3),CK(i))));
   l_tr = bitxor( bitxor(tau, bitrot(tau,13)), bitrot(tau,23));
   K(i+4) = bitxor( K(i), l_tr);
end
RK = K(5:end);
RK_hex = dec2hex(RK);

%caclulate first 4 Xs
X = zeros(1,36);
X(1:4) = DT;
%calculate round outputs
for i = 1:32
   tau = sbox( bitxor(bitxor(X(i+1),X(i+2)),bitxor(X(i+3),RK(i))));
   l_tr = bitxor(bitxor(tau,bitrot(tau,2)),bitxor(bitxor(bitrot(tau,10),bitrot(tau,18)),bitrot(tau,24)));
   X(i+4) = bitxor( X(i), l_tr);
end
XS = X(5:end);
XS_hex = dec2hex(XS);
cypher_text = flip(XS(end-3:end));
cypher_text_hex = dec2hex(cypher_text);