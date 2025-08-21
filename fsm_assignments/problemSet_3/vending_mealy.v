// Problem 3: Vending Machine (Mealy FSM, price = 20)
// Reset: synchronous, active-high

module vending_mealy(
    input  wire clk,
    input  wire rst,        // sync reset
    input  wire [1:0] coin, // 01=5, 10=10, 00=idle
    output reg  dispense,   // 1-cycle pulse
    output reg  chg5        // 1-cycle pulse (return Rs.5)
);

    // States = total so far
    localparam S0  = 2'b00;
    localparam S5  = 2'b01;
    localparam S10 = 2'b10;
    localparam S15 = 2'b11;

    reg [1:0] state, next;

    // Sequential block
    always @(posedge clk) begin
        if (rst)
            state <= S0;
        else
            state <= next;
    end

    // Next-state + Mealy outputs
    always @(*) begin
        // default values
        next = state;
        dispense = 0;
        chg5 = 0;

        case (state)
            S0: begin
                if (coin == 2'b01) next = S5;      // +5
                else if (coin == 2'b10) next = S10; // +10
            end

            S5: begin
                if (coin == 2'b01) next = S10;     // 5+5
                else if (coin == 2'b10) next = S15; // 5+10
            end

            S10: begin
                if (coin == 2'b01) next = S15;     // 10+5
                else if (coin == 2'b10) begin
                    // 10+10 = 20 → vend
                    dispense = 1;
                    next = S0;
                end
            end

            S15: begin
                if (coin == 2'b01) begin
                    // 15+5 = 20 → vend
                    dispense = 1;
                    next = S0;
                end
                else if (coin == 2'b10) begin
                    // 15+10 = 25 → vend + change
                    dispense = 1;
                    chg5 = 1;
                    next = S0;
                end
            end
        endcase
    end
endmodule
