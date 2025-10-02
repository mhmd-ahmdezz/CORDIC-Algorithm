module top
#(parameter DATA_WIDTH = 16,n_iterations = 20)
(
    input clk , // Clock Signal 
    input arst_n , //Active low Asynchronous Reset
    input valid_in , // Asserted if Input is Ready
    input signed [DATA_WIDTH -1:0]angle ,
    input signed [DATA_WIDTH -1:0]x_start , y_start , // Initial values of x and y 
    output signed [DATA_WIDTH-1:0]sine , cosine ,
    output valid_out //Asserted when output is available
);

//Internal Signals
wire signed [DATA_WIDTH-1:0] internal_angle ;
wire signed [DATA_WIDTH-1:0] internal_sine , internal_cosine ;


//CORDIC Block
cordic_rotation #(.DATA_WIDTH(DATA_WIDTH),.n_iterations(n_iterations))cordic_algorithm_rotation
(
    .clk(clk) ,
    .arst_n(arst_n) ,
    .valid_in(valid_in) ,
    .x_start(x_start) , 
    .y_start(y_start) , 
    .angle(internal_angle) ,
    .sine(internal_sine) ,
    .cosine(internal_cosine) , 
    .valid_out(valid_out)
);
//Quadrant
Quadrant_Handler #(.DATA_WIDTH(DATA_WIDTH))Quadrant_Handler_block
(
    .sine_in(internal_sine) , 
    .cosine_in(internal_cosine) , 
    .angle_in(angle),
    .sine_out(sine) , 
    .cosine_out(cosine) ,
    .angle_out(internal_angle)
);

endmodule