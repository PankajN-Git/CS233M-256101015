`timescale 1ns/1ns
`include "mycomp.v"
module tb;
reg a,b;
wire o1,o2,o3;

mycomp dut(
    .a(a),
    .b(b),
    .o1(o1),
    .o2(o2),    
    .o3(o3)
);
initial begin 
    $dumpfile("mycomp.vcd");
    $dumpvars(0, tb);
    a = 0; b = 0;
    #10;
    a = 1; b = 0;
    #10;
    a = 0; b = 1;
    #10;    
    a = 1; b = 0;
    #10;

    a = 1; b = 1;
    #10;
    $display("Test complete...");
    $finish;
end
endmodule