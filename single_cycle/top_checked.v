module top(input reset,clk
    );
	 
	 wire [31:0] pc , instr,readdata , writedata ,dataadr;
	 
	 wire memwrite;

	 mips mips_instance(clk,reset,pc,instr,memwrite,dataadr,writedata,readdata);

	 imem imem_instance(pc,instr);

	 dmem dmem_instance(clk,memwrite,dataadr,writedata,readdata);
	 
endmodule
