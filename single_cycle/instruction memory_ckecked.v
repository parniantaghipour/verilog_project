module imem(
	input [31:0] A,
    output [31:0] RD);
	
    reg [31:0] RAM [0:1023];
    assign RD = RAM[A[31:2]];
endmodule