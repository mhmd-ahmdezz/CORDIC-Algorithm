//Look-up Table holds the values of arctan(2^-i)
module  lut
#(parameter DATA_WIDTH = 16,n_iterations = 15)
(
    input [$clog2(n_iterations)-1:0]raddr , // Read Address 
    output [DATA_WIDTH-1:0]data_out // Read Output Data
);
//Storage Elements
reg [DATA_WIDTH-1:0] mem [0:n_iterations-1];

initial begin
    $readmemb("..\\MATLAB Scripts\\lut.txt",mem);
end

assign data_out = mem[raddr] ;

endmodule