`timescale 1ns / 1ns
`include"vending_mealy.v"

module tb_vending_mealy;

    reg clk;
    reg rst;
    reg [1:0] coin;
    wire dispense;
    wire chg5;

    vending_mealy dut (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .dispense(dispense),
        .chg5(chg5)
    );

    
    always #5 clk = ~clk;

    initial begin
        
        $dumpfile("vending_mealy.vcd");
        $dumpvars(0, tb_vending_mealy);
        
        
        clk = 0;
        rst = 1;
        coin = 2'b00;
        #10;
        rst = 0;
        

        // Test 1:
        $display("Test 1: Insert 4 x 5 cents (no change)");
        #10 coin = 2'b01; // S0 -> S5
        #10 coin = 2'b00;
        #10 coin = 2'b01; // S5 -> S10
        #10 coin = 2'b00;
        #10 coin = 2'b01; // S10 -> S15
        #10 coin = 2'b00;
        #10 coin = 2'b01; // S15 -> S0, dispense=1
        #10 coin = 2'b00;

        // Test 2:
        $display("\nTest 2: Insert 2 x 10 cents");
        #10 coin = 2'b10; // S0 -> S10
        #10 coin = 2'b00;
        #10 coin = 2'b10; // S10 -> S0, dispense=1, 
        #10 coin = 2'b00;

        // Test 3:
        $display("\nTest 3: Insert 5, 10, 10 cents (with change)");
        #10 coin = 2'b01; // S0 -> S5
        #10 coin = 2'b00;
        #10 coin = 2'b10; // S5 -> S10
        #10 coin = 2'b00;
        #10 coin = 2'b10; // S10-> S0, dispense=1, chg5=1
        #10 coin = 2'b00;
        
        #20 $finish;
    end
endmodule