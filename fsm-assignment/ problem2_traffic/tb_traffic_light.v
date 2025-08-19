// tb_traffic_light.v
`timescale 1ns / 1ns
`include "traffic_light.v"

module tb_traffic_light;

    reg clk;
    reg rst;
    reg tick;
    wire ns_g, ns_y, ns_r;
    wire ew_g, ew_y, ew_r;
    
    parameter CLK_PERIOD = 10; 
    parameter TICK_PERIOD = 1_000; // 1 second for 1 Hz tick

    // Instantiate the DUT
    traffic_light dut (
        .clk(clk),
        .rst(rst),
        .tick(tick),
        .ns_g(ns_g),
        .ns_y(ns_y),
        .ns_r(ns_r),
        .ew_g(ew_g),
        .ew_y(ew_y),
        .ew_r(ew_r)
    );

    // Clock and tick generation
    always #(CLK_PERIOD / 2) clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        tick = 0;
        #20; // Hold reset
        rst = 0;
        
        // Generate a 1 Hz tick pulse
        forever begin
            #((TICK_PERIOD / 2));
            tick = 1;
            #((TICK_PERIOD / 2));
            tick = 0;
        end
    end
    
    // Waveform dumping and simulation control
    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, tb_traffic_light);
        
        $display("Test Started...");
        
        // Run the simulation for a few cycles
        #(TICK_PERIOD * 15); // Simulate for 15 seconds
        
        $display("Test Completed.");
        $finish;
    end

endmodule