`timescale 1ns / 1ns

module traffic_light (
    input wire clk,
    input wire rst,
    input wire tick,
    
    output wire ns_g, ns_y, ns_r,
    
    output wire ew_g, ew_y, ew_r

);

    // State encoding for the Moore FSM
    parameter NS_GREEN = 2'b00;
    parameter NS_YELLOW = 2'b01;
    parameter EW_GREEN = 2'b10;
    parameter EW_YELLOW = 2'b11;

    // State register
    reg [1:0] current_state, next_state;
    
    // Per-phase tick counter
    reg [2:0] tick_count;
    parameter G_DUR = 3'd5; // 5 ticks for green
    parameter Y_DUR = 3'd2; // 2 ticks for yellow

    // Synchronous state transition logic with active-high reset
    always @(posedge clk) begin
        if (rst) 
        begin
            current_state <= NS_GREEN;
            tick_count <= 0;
        end 
        else 
        begin
            current_state <= next_state;
            if (tick) 
            begin
                tick_count <= tick_count + 1;
            end
        end
    end

    // Combinational next-state logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            NS_GREEN: 
            begin
                if (tick && tick_count == G_DUR - 1) next_state = NS_YELLOW;
            end
            NS_YELLOW: 
            begin
                if (tick && tick_count == Y_DUR - 1) next_state = EW_GREEN;
            end
            EW_GREEN: 
            begin
                if (tick && tick_count == G_DUR - 1) next_state = EW_YELLOW;
            end
            EW_YELLOW: 
            begin
                if (tick && tick_count == Y_DUR - 1) next_state = NS_GREEN;
            end
        endcase
    end
    
    // Combinational output logic (Moore FSM)
    assign ns_g = (current_state == NS_GREEN);
    assign ns_y = (current_state == NS_YELLOW);
    assign ns_r = (current_state == EW_GREEN || current_state == EW_YELLOW);
    assign ew_g = (current_state == EW_GREEN);
    assign ew_y = (current_state == EW_YELLOW);
    assign ew_r = (current_state == NS_GREEN || current_state == NS_YELLOW);
    

endmodule