`timescale 1ns / 1ps

module slave_fsm(
    input  wire clk,
    input  wire rst,
    input  wire req_in,
    input  wire [7:0] data_in,
    output wire ack_out,
    output reg  [7:0] last_byte_out
);

    // State parameters for the slave FSM
    parameter WAIT_REQ   = 2'd0;
    parameter ACK_ASSERT = 2'd1;
    parameter ACK_HOLD   = 2'd2;
    parameter WAIT_DROP  = 2'd3;

    reg [1:0] state, next_state;

    // Combinational logic for state transitions
    always @(*) begin
        case (state)
            WAIT_REQ:   next_state = req_in ? ACK_ASSERT : WAIT_REQ;
            ACK_ASSERT: next_state = ACK_HOLD;    // move to hold state
            ACK_HOLD:   next_state = WAIT_DROP;   // then wait for req to drop
            WAIT_DROP:  next_state = req_in ? WAIT_DROP : WAIT_REQ;
            default:    next_state = WAIT_REQ;
        endcase
    end

    // Sequential logic for state register and data latching
    always @(posedge clk) begin
        if (rst) begin
            state         <= WAIT_REQ;
            last_byte_out <= 8'd0;
        end else begin
            state <= next_state;
            // Latch the incoming data when request is first seen
            if (state == WAIT_REQ && req_in) begin
                last_byte_out <= data_in;
            end
        end
    end

    // Output logic: Assert ack for exactly two cycles
    // Ack is high only in ACK_ASSERT and ACK_HOLD states.
    assign ack_out = (state == ACK_ASSERT) || (state == ACK_HOLD);

endmodule
