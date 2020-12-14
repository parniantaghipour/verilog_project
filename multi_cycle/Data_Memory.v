module Data_memory ( clk, MemWrite, Address,WriteData,ReadData
    );
	 input clk;
	 input MemWrite;
	 input [31:0] Address ,WriteData ;
	 output  [31:0] ReadData;
	 reg MemReady;
	 reg [31:0]RAM[1023:0];
	 assign ReadData= RAM [Address[31:2]];
	 always@(posedge clk)
	 begin
	 MemReady <= 1'b1;
		if(MemWrite)
			begin
			RAM[Address[31:2]] <= WriteData;
			end
	end
endmodule
