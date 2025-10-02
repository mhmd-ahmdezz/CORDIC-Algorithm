%CORDIC Algorithm : Rotation Mode
function [sine , cosine] = CORDIC_Rotation_mode(angle)
f = 11 ;
SF = 2^f ;
n_digit = 16 ;
% Angle Mapping 
[angle_out,invert] = Quadrant_Handler(angle);

constant_i = 20 ; %number of iterations or Angles 

x = zeros(constant_i,1);
y = zeros(constant_i,1);
z = zeros(constant_i,1);

%Look up Table
lut =zeros(1,constant_i); 
for u = 1:1:constant_i
    lut(u) = atan(2^-(u-1));
end

%Constant K 
k = 1 ;
for j = 1:1:constant_i
    k = k * sec(lut(j)) ;
end

%initial Values :
x(1) = (1/k);
y(1) = 0 ;
z(1) = angle_out ;
for u=1:1:constant_i
    if z(u) > 0
        di = 1 ;
    else 
        di = -1 ;
    end
    x(u+1) = x(u)-(di*y(u)*2^-(u-1));
    y(u+1) = y(u)+(di*x(u)*2^-(u-1));
    z(u+1) = z(u)-(di*lut(u));
end

if(invert == 1)
    cosine = -x(constant_i);
    sine = -y(constant_i);
else
    cosine = x(constant_i);
    sine = y(constant_i);
end
disp(round(SF.*x));
disp(round(SF.*y));
disp(round(SF.*z));
disp(k);
disp(dec2bin(round((1/k)*SF),n_digit));
%Tan calculation is dividing last element of x and y 
tan_val = y(constant_i) / x(constant_i) ; 

end