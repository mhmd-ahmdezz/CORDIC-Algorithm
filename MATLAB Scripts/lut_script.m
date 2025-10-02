%Look-up Table
constant_i = 20 ;

i = 5 ;
f = 11 ;
N = i+f ;

SF = 2^f ; %Scale Factor
lut =zeros(constant_i,1); %Look up Table

for i = 1:1:constant_i
    lut(i) = atan(2^-(i-1));
end

for i = 1:1:constant_i
    lut(i) = round(lut(i)*SF);
end

lut_str = dec2bin(lut,N);

fileID = fopen("lut.txt","w");
for i = 1:1:constant_i
    fprintf(fileID,"%s\n",lut_str(i,1:N));
end
fclose(fileID);

