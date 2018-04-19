`timescale 1ns / 1ns

module regfile(clk, reset, wr, rD, D, rA, A, rB, B);
    parameter       N=4;    // 16 registers
    parameter       S=32;   // 32-bits

    input           clk;
    input           reset;
    input           wr;

    input   [N-1:0] rD;
    input   [N-1:0] rA;
    input   [N-1:0] rB;

    input   [S-1:0] D;
    output  [S-1:0] A;
    output  [S-1:0] B;

    // ---
    
    integer 	    i;
    reg     [S-1:0] rf [0:1<<N-1];

    // unregistered reads: use FF slices
    assign A = rf[rA];
    assign B = rf[rB];

    always @(posedge clk) begin
        if (reset) begin
            // init regfile
	        for (i = 0; i < 1<<N-1; i = i + 1) begin
	            rf[i] <= 0;
	        end
        end else begin
	        if (wr) rf[rD] <= D;
        end
    end
endmodule
