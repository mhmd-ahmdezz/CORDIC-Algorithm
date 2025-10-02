%Binary Fixed-Point Representation of bounderies of Quadrant Handler
SF = 2^11 ; %scale Factor
n_digit = 16 ;
boundaries = [-360 , -279 , -99 , 99 , 279 , 459 ,...
    639,720];
boundaries_radian = (pi/180).*boundaries;

constants = [pi , 2*pi , 3*pi , 4*pi];
constants_SF = round(SF.*constants);
constants_str = dec2bin(constants_SF,n_digit);

boundaries_radian_SF = round(SF.*boundaries_radian) ;
boundaries_radian_str = dec2bin(boundaries_radian_SF,n_digit);

fileID = fopen("boundries_binary_representation.txt",'w');
for i = 1:1:8
    fprintf(fileID,"%s\n",boundaries_radian_str(i,1:n_digit));
end

for i = 1:1:4
    fprintf(fileID,"%s\n",constants_str(i,1:n_digit));
end
fclose(fileID);