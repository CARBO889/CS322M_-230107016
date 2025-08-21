// Testbench for Problem 1: Mealy Sequence Detector (1101, overlapping)
`timescale 1ns/1ps

module tb_seq_detect_mealy;
    reg  clk, rst, din;
    wire y;

    seq_detect_mealy dut(
        .clk(clk),
        .rst(rst),
        .din(din),
        .y(y)
    );

    // 100 MHz clock (10 ns period)
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // helper: drive one bit for exactly one clock
    task send_bit(input b);
    begin
        din = b;
        @(posedge clk);
        #1; // small delay to separate edges in VCD
    end
    endtask

    integer i;

    // A couple of streams to show overlap and multiple detections
    reg [0:10] stream0; // length 11: 11011011101
    initial stream0 = 11'b11011011101;

    reg [0:15] stream1; // another test: 111011010110101
    initial stream1 = 16'b111011010110101;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_seq_detect_mealy);

        // init
        rst = 1; din = 0;
        repeat (2) @(posedge clk);
        rst = 0;

        // Stream 0: 11011011101
        $display("Applying stream0 = 11011011101");
        for (i = 0; i < 11; i = i + 1) begin
            send_bit(stream0[i]);
            $display("t=%0t ns  idx=%0d  din=%0d  y=%0d", $time, i, din, y);
        end

    
        din = 0;
        repeat (3) @(posedge clk);

        //  Stream 1: 111011010110101
        $display("Applying stream1 = 111011010110101");
        for (i = 0; i < 16; i = i + 1) begin
            send_bit(stream1[i]);
            $display("t=%0t ns  idx=%0d  din=%0d  y=%0d", $time, i, din, y);
        end

        repeat (4) @(posedge clk);
        $finish;
    end
endmodule
