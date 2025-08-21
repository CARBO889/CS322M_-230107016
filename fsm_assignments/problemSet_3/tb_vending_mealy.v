// Testbench for Problem 3: Vending Machine FSM
`timescale 1ns/1ps

module tb_vending_mealy;
    reg clk, rst;
    reg [1:0] coin;
    wire dispense, chg5;

    vending_mealy dut(.clk(clk), .rst(rst), .coin(coin),
                      .dispense(dispense), .chg5(chg5));

    // Clock gen (100 MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    // Helper tasks
    task put5; begin
        coin = 2'b01; @(posedge clk); coin = 2'b00; @(posedge clk);
    end endtask

    task put10; begin
        coin = 2'b10; @(posedge clk); coin = 2'b00; @(posedge clk);
    end endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_vending_mealy);

        // init
        rst = 1; coin = 2'b00;
        repeat (2) @(posedge clk);
        rst = 0;

        // Tests
        // Case 1: 10 + 10 = 20 (vend)
        put10; put10;

        // Case 2: 5 + 5 + 10 = 20 (vend)
        put5; put5; put10;

        // Case 3: 10 + 5 + 10 = 25 (vend + change)
        put10; put5; put10;

        // Case 4: 5 + 10 + 5 = 20 (vend)
        put5; put10; put5;

        #50 $finish;
    end
endmodule
