module mips(input clk,reset,
output [31:0]pc,
input [31:0] instr,
output memwrite,
output [31:0] aluout , writedata,
input [31:0] readdata);
wire MemtoReg,PCsrc,ALUsrc,RegDst,RegWrite,SgnZero;
wire [2:0] ALUOP;
controller controller_instance(instr[31:26],instr[5:0],zero,MemtoReg,memwrite,PCsrc,ALUOP,ALUsrc,RegDst,RegWrite,SgnZero);
datapath datapath_instance(clk,reset,MemtoReg,PCsrc,ALUsrc,RegDst,RegWrite,SgnZero,ALUOP,zero,pc,instr,aluout,writedata,readdata);

endmodule