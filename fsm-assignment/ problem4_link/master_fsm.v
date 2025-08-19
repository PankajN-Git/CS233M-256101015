`timescale 1ns / 1ns

module master_fsm (
    input wire clk,
    input wire rst,
    input wire ack,
    output reg req,
    output reg [7:0] data,
    output reg done
);

    // State encoding
    parameter S_IDLE = 2'b00;
    parameter S_REQ = 2'b01;
    parameter S_WAIT_ACK = 2'b10;
    parameter S_TX_DATA = 2'b11;

    reg [1:0] current_state, next_state;

    reg [1:0] byte_count;

    always @(posedge clk) begin
        if (rst) begin
            current_state <= S_IDLE;
            byte_count <= 0;
            req <= 0;
            data <= 0;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == S_TX_DATA && ack)
             begin
                byte_count <= byte_count + 1;
            end
            if (current_state == S_REQ)
             begin
                req <= 1;
            end 
            else 
            begin
                req <= 0;
            end
        end
    end

    
    always @(*) begin
        next_state = current_state;
        case (current_state)
            S_IDLE: 
            begin
                if (req) next_state = S_WAIT_ACK; 
            end
            S_WAIT_ACK: 
            begin
                if (ack) next_state = S_TX_DATA;
            end
            S_TX_DATA: 
            begin
                if (ack && byte_count == 3) 
                begin
                    next_state = S_IDLE;
                    done = 1;
                end 
                else if (ack) 
                begin
                    next_state = S_TX_DATA;
                end
            end
            default: next_state = S_IDLE;
        endcase
    end

    initial begin
        data = 8'hA0;
    end
    
    always @(posedge clk) begin
        if (ack) begin
            case (byte_count)
                0: data <= 8'hA1;
                1: data <= 8'hA2;
                2: data <= 8'hA3;
                3: data <= 8'hA0;
            endcase
        end
    end

endmodule