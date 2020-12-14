module latch1(reset,clk,RegWriteD,MemtoRegD,MemWriteD,AluControlD,AluSrcD,RegDstD,RegWriteE,MemtoRegE,MemWriteE,AluControlE,AluSrcE,RegDstE,
RD1D,RD1E,RD2D,RD2E,RsD,RsE,RtD,RtE,RdD,RdE,flush,SignImmD,
SignImmE
    );
	 input [31:0] SignImmD,RD1D,RD2D;
	 input [4:0] RsD,RtD,RdD;
	 input clk,RegWriteD,MemtoRegD,MemWriteD,AluSrcD,RegDstD,flush,reset;
	 input [2:0] AluControlD;
	 output reg RegWriteE,MemtoRegE,MemWriteE,AluSrcE,RegDstE;
	 output reg [2:0] AluControlE;
	 output reg [4:0] RsE,RtE,RdE;
	 output reg [31:0] SignImmE , RD1E,RD2E;
	 always @( posedge clk,reset )
		begin 
			if( flush  )
				begin
					RegWriteE <= 0;
					MemtoRegE <= 0;
					MemWriteE <= 0;
					AluSrcE <= 0;
					RegDstE <= 0;
					AluControlE <= 0;
					RD1E <= 0;
					RD2E <= 0;
					RsE <= 0;
					RtE <= 0;
					RdE <= 0;
					SignImmE <= 0;

				end
				else
				begin
					RegWriteE <= RegWriteD;
					MemtoRegE <= MemtoRegD;
					MemWriteE <= MemWriteD;
					AluSrcE <= AluSrcD;
					RegDstE <= RegDstD;
					AluControlE <= AluControlD;
					RD1E <= RD1D;
					RD2E <= RD2D;
					RsE <= RsD;
					RtE <= RtD;
					RdE <= RdD;
					SignImmE <= SignImmD;
				end
			end


endmodule
