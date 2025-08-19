`timescale 1ns / 1ns

module vending_mealy (
    input wire clk,
    input wire rst,
    input wire [1:0] coin,  
    output reg dispense,    
    output reg chg5         
);

    
    parameter S0 = 2'b00;  
    parameter S5 = 2'b01;  // 5 rs
    parameter S10 = 2'b10; // 10 rs
    parameter S15 = 2'b11; // 15 rs
    
    
    reg [1:0] current_state, next_state;

     always @(posedge clk) begin
        if (rst) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    
    always @(*) begin
        next_state = current_state;
        dispense = 1'b0;
        chg5 = 1'b0;

        case (current_state)
            S0: begin
                if (coin == 2'b01) next_state = S5;
                else if (coin == 2'b10) next_state = S10;
                else next_state = S0;
            end
            S5: begin
                if (coin == 2'b01) next_state = S10;
                else if (coin == 2'b10) next_state = S15;
                else next_state = S5;
            end
            S10: begin
                if (coin == 2'b01) next_state = S15;
                else if (coin == 2'b10) begin
                    next_state = S0;
                    dispense = 1'b1;
                end else next_state = S10;
            end
            S15: begin
                if (coin == 2'b01) begin
                    next_state = S0;
                    dispense = 1'b1;
                end else if (coin == 2'b10) begin
                    next_state = S0;
                    dispense = 1'b1;
                    chg5 = 1'b1;
                end else next_state = S15;
            end
            default: next_state = S0;
        endcase
    end

endmodule