module cordic_rotation_tb();
//declare the local , reg , and wire identifier 
parameter DATA_WIDTH = 16 ;
reg clk = 1'b0 ;
reg arst_n ;
reg valid_in ;
reg [DATA_WIDTH-1:0]x_start , y_start ;
reg [DATA_WIDTH-1:0]angle_in ;
wire [DATA_WIDTH-1:0]sine , cosine ; 
wire valid_out ;  
//Instantiate the module under test
cordic_rotation #(.DATA_WIDTH(DATA_WIDTH)) DUT(clk , arst_n , valid_in , x_start , 
    y_start , angle_in ,sine ,cosine ,valid_out) ;
//Generate the clock
localparam T = 10 ;
always #(T/2) clk = ~ clk ;
//Create the stimulus 
initial 
begin
    x_start = 16'b0000000010011011 ;
    y_start = 16'd0 ;
    angle_in = 16'b0000000110111111;
    valid_in = 1'b0 ;
    arst_n = 1'b0 ;
    #2 arst_n = 1'b1 ;
    valid_in = 1'b1 ;
    @(negedge clk) valid_in = 1'b0 ;
    repeat(10) @(posedge clk);
    angle_in = 16'b1111110111101000 ;
    @(negedge clk);
    valid_in = 1'b1 ;
    @(negedge clk) valid_in = 1'b0 ;
    repeat(10) @(posedge clk);
    #2 $stop; 

end
endmodule