module latch2(reset,clk,RegWriteE,MemtoRegE,MemWriteE,RegWriteM,MemtoRegM,MemWriteM,ALUOutE,ALUOutM,WriteDataE,WriteDataM, WriteRegE,WriteRegM
    );
	 input clk,RegWriteE, MemtoRegE, MemWriteE,reset;
	 input [4:0] WriteRegE;
	 input [31:0] ALUOutE, WriteDataE;
 	 output reg [4:0] WriteRegM;
	 output reg [31:0] ALUOutM, WriteDataM;
	 output reg RegWriteM, MemtoRegM, MemWriteM;
	 always @( posedge clk)
		begin
			if(reset)
				begin
					RegWriteM <= 0;
					MemtoRegM <= 0;
					MemWriteM <= 0;
					ALUOutM <= 0;
					WriteDataM <= 0;
					WriteRegM <= 0;

				end
			else
				begin
					RegWriteM <= RegWriteE;
					MemtoRegM <= MemtoRegE;
					MemWriteM <= MemWriteE;
					ALUOutM <= ALUOutE;
					WriteDataM <= WriteDataE;
					WriteRegM <= WriteRegE;
				end
		end


endmodule
