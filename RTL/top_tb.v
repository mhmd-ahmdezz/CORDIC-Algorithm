module top_tb();
//declare the local , reg , and wire identifier
parameter DATA_WIDTH = 16;
parameter n_iterations = 20 ;
reg clk = 1'b0 ; // Clock Signal 
reg arst_n ; //Active low Asynchronous Reset
reg valid_in ;
reg signed [DATA_WIDTH -1:0]angle ;
reg signed [DATA_WIDTH -1:0] x_start , y_start ; // Initial values of x and y 
wire signed[DATA_WIDTH -1:0]sine , cosine ;
wire valid_out ; //Asserted when output is available
//Instantiate the module under test
top #(.DATA_WIDTH(DATA_WIDTH),.n_iterations(n_iterations)) DUT(clk , arst_n , valid_in , angle , x_start ,
     y_start , sine , cosine ,valid_out);

localparam i = 5  ;
localparam f = 11.0 ;
localparam SF = 2.0**-f ;
localparam PI = 3.141592653589793 ;
localparam tolerance = 0.004 ;

//Angles 

reg signed [DATA_WIDTH -1:0] angles [0:60];
reg signed [DATA_WIDTH -1:0] results_sine [0:60];
reg signed [DATA_WIDTH -1:0] results_cosine [0:60];

initial begin
    $readmemb("..\\MATLAB Scripts\\angles.txt",angles);
    $readmemb("..\\MATLAB Scripts\\results_sine.txt",results_sine);
    $readmemb("..\\MATLAB Scripts\\results_cosine.txt",results_cosine);
end


task drive;
    input reg signed [DATA_WIDTH -1:0] angle_in ;
    begin
        angle = angle_in ;
        valid_in = 1'b1 ;
        @(negedge clk) valid_in = 1'b0 ;
        repeat(n_iterations-1) @(posedge clk);
    end
endtask

task error;
    input reg signed [DATA_WIDTH-1:0] expected , actual ;
    output real err_abs;
   
    begin
        err_abs = expected - actual ;
        if(err_abs<0)
            err_abs = -err_abs ;
    end
endtask



task check;
    input reg signed [DATA_WIDTH-1:0] expected_sine , expected_cosine ;
    real temp_abs;
    begin
        error(expected_sine,sine, temp_abs);
        error(expected_cosine,cosine, temp_abs);

        $fdisplay(fd_abs_error_sine,"%f",temp_abs*SF);
        $fdisplay(fd_abs_error_cosine,"%f",temp_abs*SF);

        if((temp_abs *SF)> tolerance) begin
            $display("The Output is : ");
            $display("@%0d , angle(degree) : %f : angle (radian) : %f , sine : %f , cosine : %f ",$time ,$itor(angle*SF*(180/PI))  ,$itor(angle*SF)
                ,$itor(sine*SF) ,$itor(cosine*SF)) ;
            $display("But it should be : ");
            $display("sine : %f , Error : %f",$itor(expected_sine*SF) ,temp_abs*SF) ;
            $display("cosine : %f , Error : %f",$itor(expected_cosine*SF) ,temp_abs*SF) ;
            $display("-------------------------------------------------------------------------------");
        end
        else 
            $display("----------------------------------Test Passed----------------------------------");
    end

endtask

//Generate the Clock 
localparam T = 10 ;
always #(T/2) clk = ~ clk ;
//Create the stimulus using initial block 

integer j ;
integer fd_sine_out , fd_cosine_out ;
integer fd_abs_error_sine ;
integer fd_abs_error_cosine;

initial begin
    fd_sine_out = $fopen("sines_out.txt", "w");
    fd_cosine_out = $fopen("cosines_out.txt", "w");
    fd_abs_error_sine = $fopen("result_abs_error_sine.txt","w");
    fd_abs_error_cosine = $fopen("result_abs_error_cosine.txt","w");
end

initial 
begin
    // x_start = 32'b00000100110110111010011101101101;
    x_start = 16'b0000010011011100;
    y_start = {DATA_WIDTH{1'b0}} ;
    valid_in = 1'b0 ;
    arst_n = 1'b0 ;
    #2 arst_n = 1'b1 ;
    
    for(j=0;j<=60;j=j+1) begin
        drive(angles[j]);
        @(negedge clk);
        check(results_sine[j],results_cosine[j]);
        $fdisplay(fd_sine_out,"%0d",sine);
        $fdisplay(fd_cosine_out,"%0d",cosine);
        @(negedge clk);
    end

    // for(j=360;j>=0;j=j-1) begin
    //     angle = (-j*(PI/180))*(2**f);
    //     valid_in = 1'b1 ;
    //     @(negedge clk) valid_in = 1'b0 ;
    //     repeat(n_iterations-1) @(posedge clk);
    //     @(negedge clk);
    //     $fdisplay(fd_sine_out,"%0d",sine);
    //     $fdisplay(fd_cosine_out,"%0d",cosine);
    //     @(negedge clk);
    // end
    // for(j=1;j<=720;j=j+1) begin
    //     angle = (j*(PI/180))*(2**f);
    //     valid_in = 1'b1 ;
    //     @(negedge clk) valid_in = 1'b0 ;
    //     repeat(n_iterations-1) @(posedge clk);
    //     @(negedge clk);
    //     $fdisplay(fd_sine_out,"%0d",sine);
    //     $fdisplay(fd_cosine_out,"%0d",cosine);
    //     @(negedge clk);
    // end

    #2 $stop; 
end
endmodule