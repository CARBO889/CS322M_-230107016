`timescale 1ns / 1ps

module link_top(
    input  wire clk,
    input  wire rst,
    output wire done
);

// Internal wires for connecting the two FSMs
wire req_sig;
wire ack_sig;
wire [7:0] data_bus;
wire [7:0] slave_last_byte; // Observable in simulation

// Instantiate the Master FSM
master_fsm u_master (
    .clk(clk),
    .rst(rst),
    .ack_in(ack_sig),       // renamed
    .req_out(req_sig),      // renamed
    .done_out(done),        // renamed
    .data_out(data_bus)     // renamed
);

// Instantiate the Slave FSM
slave_fsm u_slave (
    .clk(clk),
    .rst(rst),
    .req_in(req_sig),         // renamed
    .data_in(data_bus),
    .ack_out(ack_sig),        // renamed
    .last_byte_out(slave_last_byte) // renamed
);

endmodule
