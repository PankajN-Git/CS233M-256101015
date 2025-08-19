`timescale 1ns/1ns
`include "seq_detect_mealy.v"

module tb_seq_detect_mealy;

reg clk;
reg rst;
reg din;
wire y;

seq_detect_mealy dut(
   .clk(clk),
   .rst(rst),
   .din(din),
   .y(y) 
);

always #5 clk = ~clk;

initial begin
        clk = 0;
    end

initial begin 
    $dumpfile("seq_detect_mealy.vcd");
    $dumpvars(0, dut);

    rst = 1;
    clk = 0;
    din = 0;
    #10;
    rst = 0;

    $display("Test Start.....");

    //seq 1 : 1101
   
    #10 din = 1;
    #10 din = 1;
    #10 din = 0;
    #10 din = 1;

    //Seq 2: 111101 (overlapping)
    #10 din = 1;
    #10 din = 1;
    #10 din = 1;
    #10 din = 1;
    #10 din = 0;
    #10 din = 1;

    // Seq 3: 11011011101 (overlaps)
        #10 din = 1;
        #10 din = 1;
        #10 din = 0;
        #10 din = 1;
        #10 din = 1;
        #10 din = 0;
        #10 din = 1;
        #10 din = 1;
        #10 din = 1;
        #10 din = 0;
        #10 din = 1;
     #20
     $display("Test_Completed....");  
     $finish;
end
endmodule         



