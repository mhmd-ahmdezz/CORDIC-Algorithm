//Quadrant_Handler : Handles angles from -2*pi : 4*pi 
module Quadrant_Handler
#(parameter DATA_WIDTH = 16)
(
    input signed [DATA_WIDTH-1:0] sine_in , cosine_in ,
    input signed [DATA_WIDTH -1:0] angle_in ,
    output reg signed [DATA_WIDTH-1:0] sine_out , cosine_out ,
    output reg signed [DATA_WIDTH-1:0] angle_out
);


 reg signed [DATA_WIDTH -1:0] boundaries [0:11] ;

 initial begin
     $readmemb("F:\\Chipions\\CORDIC Algorithm\\MATLAB Scripts\\boundries_binary_representation.txt",boundaries);
 end
/*
    -360 = 0 , -279 = 1 , -99 = 2 , 99 = 3 , 279 = 4 , 459 = 5 ,...
    639 = 6,720 = 7
      PI   = boundaries[8] ;
    2*PI   = boundaries[9] ;
    3*PI   = boundaries[10] ;
    4*PI   = boundaries[11] ;    

*/

 always @(*)
 begin
     //Default Values : 
     sine_out = sine_in ;
     cosine_out = cosine_in ;
     angle_out = angle_in ;

     if(angle_in < 0) begin
         if(angle_in >= boundaries[0] && angle_in < boundaries[1]) begin
             angle_out = angle_in + boundaries[9] ;
             sine_out = sine_in ;
             cosine_out = cosine_in ;
         end
         else if(angle_in >= boundaries[1] && angle_in < boundaries[2]) begin
             angle_out = angle_in + boundaries[8] ;
             sine_out = -sine_in ;
             cosine_out = -cosine_in ;
         end
         else if(angle_in >= boundaries[2] && angle_in < 0) begin
             angle_out = angle_in ;
             sine_out = sine_in ;
             cosine_out = cosine_in ;
         end
     end
     else begin
         if(angle_in >= 0 && angle_in < boundaries[3]) begin
             angle_out = angle_in;
             sine_out = sine_in ;
             cosine_out = cosine_in ;
         end
         else if(angle_in >= boundaries[3] && angle_in < boundaries[4]) begin
             angle_out = angle_in - boundaries[8] ;
             sine_out = -sine_in ;
             cosine_out = -cosine_in ;
         end
         else if(angle_in >= boundaries[4] && angle_in < boundaries[5]) begin
             angle_out = angle_in - boundaries[9] ;
             sine_out = sine_in ;
             cosine_out = cosine_in ;
         end
         else if(angle_in >= boundaries[5] && angle_in < boundaries[6]) begin
             angle_out = angle_in - boundaries[10] ;
             sine_out = -sine_in ;
             cosine_out = -cosine_in ;
         end
         else if(angle_in >= boundaries[6] && angle_in <= boundaries[7]) begin
             angle_out = angle_in - boundaries[11] ;
             sine_out = sine_in ;
             cosine_out = cosine_in ;
         end
     end
 end

endmodule