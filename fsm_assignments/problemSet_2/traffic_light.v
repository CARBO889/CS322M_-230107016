// Problem 2: Two-Road Traffic Light (Moore FSM)
// Reset: synchronous, active-high

module traffic_light(
    input  wire clk,
    input  wire rst,   // sync reset
    input  wire tick,  // 1-cycle pulse (1 Hz)
    output reg  ns_g, ns_y, ns_r,
    output reg  ew_g, ew_y, ew_r
);

    // States
    localparam NS_G = 2'b00;
    localparam NS_Y = 2'b01;
    localparam EW_G = 2'b10;
    localparam EW_Y = 2'b11;

    reg [1:0] state, next;
    reg [2:0] tick_count; // counts ticks for each phase

    // State register + counter
    always @(posedge clk) begin
        if (rst) begin
            state <= NS_G;
            tick_count <= 3'd0;
        end else begin
            state <= next;
            if (tick) begin
                if ((state == NS_G && tick_count == 3'd4) ||
                    (state == NS_Y && tick_count == 3'd1) ||
                    (state == EW_G && tick_count == 3'd4) ||
                    (state == EW_Y && tick_count == 3'd1))
                    tick_count <= 3'd0; // reset for next phase
                else
                    tick_count <= tick_count + 1'b1;
            end
        end
    end

    // Next-state logic
    always @(*) begin
        next = state;
        case (state)
            NS_G: if (tick && tick_count == 3'd4) next = NS_Y; // after 5 ticks
            NS_Y: if (tick && tick_count == 3'd1) next = EW_G; // after 2 ticks
            EW_G: if (tick && tick_count == 3'd4) next = EW_Y; // after 5 ticks
            EW_Y: if (tick && tick_count == 3'd1) next = NS_G; // after 2 ticks
        endcase
    end

    // Output logic (Moore)
    always @(*) begin
        // default off
        ns_g=0; ns_y=0; ns_r=0;
        ew_g=0; ew_y=0; ew_r=0;

        case (state)
            NS_G: begin ns_g=1; ew_r=1; end
            NS_Y: begin ns_y=1; ew_r=1; end
            EW_G: begin ew_g=1; ns_r=1; end
            EW_Y: begin ew_y=1; ns_r=1; end
        endcase
    end

endmodule
