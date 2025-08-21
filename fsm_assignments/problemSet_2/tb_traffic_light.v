// Testbench for Problem 2: Two-Road Traffic Light
`timescale 1ns/1ps

module tb_traffic_light;
    reg clk, rst, tick;
    wire ns_g, ns_y, ns_r, ew_g, ew_y, ew_r;

    traffic_light dut(
        .clk(clk), .rst(rst), .tick(tick),
        .ns_g(ns_g), .ns_y(ns_y), .ns_r(ns_r),
        .ew_g(ew_g), .ew_y(ew_y), .ew_r(ew_r)
    );

    // 100 MHz clock
    initial clk = 0;
    always #5 clk = ~clk;

    integer cyc;
    always @(posedge clk) begin
        cyc <= cyc + 1;
        tick <= (cyc % 20 == 0); // 1 pulse every 20 cycles (fast sim)
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_traffic_light);

        rst = 1; tick = 0; cyc = 0;
        repeat (2) @(posedge clk);
        rst = 0;

        // Run for ~60 ticks (~1200 cycles here)
        repeat (1200) @(posedge clk);

        $finish;
    end
endmodule
