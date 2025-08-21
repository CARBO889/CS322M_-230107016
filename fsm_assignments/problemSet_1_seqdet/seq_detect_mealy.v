// Problem 1: Mealy Sequence Detector (pattern 1101, overlapping)


module seq_detect_mealy(
    input  wire clk,
    input  wire rst,   
    input  wire din,   
    output reg  y      
);

    // State encoding (binary)
    localparam S0 = 2'b00; // no match
    localparam S1 = 2'b01; // saw "1"
    localparam S2 = 2'b10; // saw "11"
    localparam S3 = 2'b11; // saw "110"

    reg [1:0] state, next;


    always @(posedge clk) begin
        if (rst)
            state <= S0;
        else
            state <= next;
    end

    
    always @(*) begin
        
        next = state;
        y    = 1'b0;

        case (state)
            S0: begin
                if (din) next = S1;
                else     next = S0;
            end

            S1: begin
                if (din) next = S2;
                else     next = S0;
            end

            S2: begin
                if (din) next = S2;   
                else     next = S3;   
            end

            S3: begin
                if (din) begin
                    // "1101" detected right now (Mealy)
                    y    = 1'b1;
                    next = S1;       
                end else begin
                    next = S0;
                end
            end

            default: begin
                next = S0;
            end
        endcase
    end

endmodule
