%Script : Proof of concept of mapping angles (Quardant handler)
function [angle_out,invert] = Quadrant_Handler(angle_in)

%invert : to indicate that the output should be inverted (e.g. Sine , Cosine 
% calculations)

if(angle_in>= (-360*pi)/180 && angle_in< (-279*pi)/180)
    angle_out = angle_in + (2*pi) ;invert = 0 ;
elseif(angle_in>= (-279*pi)/180 && angle_in< (-99*pi)/180)
    angle_out = angle_in + pi ; invert = 1 ;
elseif(angle_in>= (-99*pi)/180 && angle_in< (0*pi)/180)
    angle_out = angle_in ; invert = 0;
else
    if(angle_in>= (0*pi)/180 && angle_in< (99*pi)/180)
        angle_out = angle_in; invert = 0 ;
    elseif(angle_in>= (99*pi)/180 && angle_in< (279*pi)/180) 
        angle_out = angle_in - (pi) ; invert = 1 ;
    elseif(angle_in>= (279*pi)/180 && angle_in< (459*pi)/180)
        angle_out = angle_in - (2*pi) ; invert = 0 ;
    elseif(angle_in>= (459*pi)/180 && angle_in< (639*pi)/180)
        angle_out = angle_in - (3*pi) ; invert = 1 ;
    elseif(angle_in>= (639*pi)/180 && angle_in<= (720*pi)/180)
        angle_out = angle_in - (4*pi) ; invert = 0 ;
    end
end