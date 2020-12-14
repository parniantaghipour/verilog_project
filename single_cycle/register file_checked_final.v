module regfile(
	input clk,
    input WE3,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
	output [31:0] RD1,
	output [31:0] RD2);
					
    reg [31:0] register [0:31];
   assign  RD1 = register[A1];
   assign  RD2 = register[A2];   
   always @(posedge clk) 
		begin
			if (WE3 == 1)	register[A3] <= WD3;
			register[0] <= 32'h00000000;
		end
endmodule