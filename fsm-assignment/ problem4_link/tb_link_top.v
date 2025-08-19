`timescale 1ns / 1ns
`include "master_fsm.v"
`include "slave_fsm.v"
`include "link_top.v"

module tb_link_top;

    reg clk;
    reg rst;
    wire done;

    link_top dut (
        .clk(clk),
        .rst(rst),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("link_top.vcd");
        $dumpvars(0, dut);

        rst = 1;
        #10;
        rst = 0;

        // Monitor handshake
        $monitor("Time=%0t: req=%b, ack=%b, data=%h", $time, dut.master_inst.req, dut.slave_inst.ack, dut.master_inst.data);

    
        wait(done);
        
        #20 $finish;
    end
endmodule