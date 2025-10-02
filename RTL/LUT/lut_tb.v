`timescale 1ns / 1ns 
module lut_tb();
//declare the local , reg , and wire identifiers 
parameter DATA_WIDTH = 16 , ADDR_WIDTH = 4 ;
reg clk = 1'b0 ; // Clock Signal
reg arst_n ; // Active-Low Asynchronous Reset
reg [ADDR_WIDTH-1:0]raddr ; // Read Address 
wire [DATA_WIDTH-1:0]data_out ; // Read Output Data
//Instantiate the module under test
lut #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) DUT(clk , arst_n , raddr , data_out);
//Generate the Clock 
localparam T = 10 ;
always #(T/2) clk = ~ clk ;
//Create the stimulus using initial 

initial begin
    raddr = 'd0 ;
    arst_n = 1'b1 ;
  
    @(negedge clk) raddr = 'd0 ;
    $display("Address : %0d , Data : %0d ",raddr , data_out);
    repeat(15) @(negedge clk) begin
        raddr = raddr + 1 ;
        $display("Address : %0d , Data : %0d ",raddr , data_out);
    end 
    #4 arst_n =1'b0 ;
    #2 arst_n = 1'b1 ;

    #4 $stop ;

end
endmodule