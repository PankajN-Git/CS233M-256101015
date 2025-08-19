`timescale 1ns / 1ns

module seq_detect_mealy(
    input wire clk,
    input wire rst,
    input wire din,
    output reg y
);

    
    parameter S0 = 2'b00; 
    parameter S1 = 2'b01; 
    parameter S2 = 2'b10; 
    parameter S3 = 2'b11; 

    // State register
    reg [1:0] current_state, next_state;

    //positive egde logic
    always @(posedge clk) 
    begin
        if (rst) 
        begin
            current_state <= S0;
        end 
        else 
        begin
            current_state <= next_state;
        end
    end

    // State transition
    always @(*) 
    begin
        next_state = current_state;

        case (current_state)
            S0: 
            begin
                if (din == 1'b1) next_state = S1;
                else next_state = S0;
                y = 1'b0;
            end
            S1: 
            begin
                if (din == 1'b1) next_state = S2;
                else next_state = S0;
                y = 1'b0;
            end
            S2: 
            begin
                if (din == 1'b0) next_state = S3;
                else next_state = S2; 
                y = 1'b0;
            end
            S3: 
            begin
                if (din == 1'b1) begin
                    next_state = S2; 
                    y = 1'b1;
                end else begin
                    next_state = S0;
                end
            end
            default: next_state = S0;
        endcase
    end

endmodule