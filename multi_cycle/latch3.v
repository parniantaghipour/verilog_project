module latch3(reset,clk,RegWriteM,MemtoRegM,RegWriteW,MemtoRegW,
WriteRegM,
WriteRegW,ReadDataM,ReadDataW,ALUOutM,ALUOutW);
input [31:0] ReadDataM,ALUOutM;
input [4:0] WriteRegM;
input RegWriteM,MemtoRegM,clk,reset;
output reg RegWriteW,MemtoRegW;
output reg [4:0] WriteRegW;
output reg [31:0] ReadDataW,ALUOutW;
always @ (posedge clk)
	begin
		if(reset)
			begin
				RegWriteW <= 0;
				MemtoRegW <= 0;
				WriteRegW <= 0;
				ReadDataW <= 0;
				ALUOutW <= 0;

			end
		else
			begin
				RegWriteW <= RegWriteM;
				MemtoRegW <= MemtoRegM;
				WriteRegW <= WriteRegM;
				ReadDataW <= ReadDataM;
				ALUOutW <= ALUOutM;
			end
	end
endmodule
