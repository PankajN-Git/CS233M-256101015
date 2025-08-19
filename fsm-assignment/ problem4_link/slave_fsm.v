`timescale 1ns / 1ns

module slave_fsm (
    input wire clk,
    input wire rst,
    input wire req,
    input wire [7:0] data_in,
    output reg ack,
    output reg [7:0] last_byte
);

    reg [1:0] ack_count;

    always @(posedge clk)
     begin
        if (rst) begin
            ack <= 0;
            ack_count <= 0;
            last_byte <= 0;
        end 
        else
         begin
            if (req) 
            begin
                last_byte <= data_in; // Latch data on req
            end
            
            if (req && !ack)
             begin
                ack <= 1;
                ack_count <= 1;
            end 
            else if (ack) 
            begin
                ack_count <= ack_count + 1;
                if (ack_count == 2) begin
                    ack <= 0;
                    ack_count <= 0;
                end
            end 
            else
             begin
                ack <= 0;
                ack_count <= 0;
            end
        end
    end
endmodule