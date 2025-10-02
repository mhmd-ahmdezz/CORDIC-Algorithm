//CORDIC Algorithm Implementation (Rotation Mode)
module cordic_rotation
#(parameter DATA_WIDTH = 16,n_iterations = 20)
(
    input clk , // Clock Signal 
    input arst_n , // Active - low Aysnchronous Reset
    input valid_in , // Valid_in Flag to start the iterations
    input [DATA_WIDTH-1:0]x_start , y_start , // Initial values of x and y
    input signed[DATA_WIDTH-1:0]angle , // Desired angle to calculate it's trigonometric function
    output signed [DATA_WIDTH-1:0]sine , cosine , // Sine and Cosine function of input angle 
    output valid_out // Valid_out Flag at which the output is valid 
);

reg [$clog2(n_iterations)-1:0]iteration_counter ;
reg signed [DATA_WIDTH-1:0] x , y , z ;
wire [DATA_WIDTH-1:0] e_i ;

//Look up Table 
lut #(.DATA_WIDTH(DATA_WIDTH),.n_iterations(n_iterations)) look_up_table
( 
    .raddr(iteration_counter) , 
    .data_out(e_i)
);

always @(posedge clk , negedge arst_n)
begin
    if(~arst_n) begin
        iteration_counter <= 'd0 ;
    end
    else if(valid_in)
        {x , y , z } <= {x_start , y_start , angle};
    else begin
        if(z > 0) begin
            x <= x - (y>>>iteration_counter);
            y <= y + (x>>>iteration_counter);
            z <= z - e_i ;
        end
        else begin
            x <= x + (y>>>iteration_counter);
            y <= y - (x>>>iteration_counter);
            z <= z + e_i ;
        end

        iteration_counter <= (iteration_counter == n_iterations-1) ? 'd0 : iteration_counter + 1 ;
        
    end
end

assign valid_out = (iteration_counter == n_iterations-1) ;
assign sine = y ;
assign cosine = x ;

endmodule