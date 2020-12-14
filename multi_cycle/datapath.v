module datapath(
input clk, reset,
input RegWriteD, MemtoRegD , MemWriteD ,
input [2:0] ALUControlD ,
input ALUsrcD , RegDstD , PCSrcdD, sgnzero ,
input StallF , StallD , ForwardAD , ForwardBD , FlushE , 
input [1:0] ForwardAE , ForwardBE ,
output EqualD ,
output [31:0] instrD ,
output RegWriteM , RegWriteW , RegWriteE , MemtoRegE,MemtoRegM,
output [4:0] WriteRegE , WriteRegM , WriteRegW ,
output [4:0] RsE, RtE );
wire [31:0] pc_prime , PCF , PCPlus4F , RD ,PCPlus4D , PCBranchD;
wire   MemtoRegW;
wire MemWriteE , MemWriteM ;
wire [2:0] ALUControlE;
wire ALUsrcE , RegDstE ;
wire [4:0] RdE ;
wire [31:0] SignimmD , SignimmE , SignimmD_shift;
wire [31:0] ResultW ;
wire [31:0] RD1D , RD2D , RD1E , RD2E ;
wire [31:0] ALUOutE , ALUOutM , ALUOutW ; 
wire [31:0] a , b ;
wire [31:0] SrcAE , SrcBE ;
wire [31:0] WriteDataE , WriteDataM ;
wire [31:0] ReadDataM , ReadDataW ;
wire zero ;



flopr#(32) flopr (.stall (StallF),.clk (clk),.reset (reset),.d (pc_prime),.q (PCF));

adder adder_0 (.a (PCF) ,.b (4) ,.y (PCPlus4F));

instruction_memory instruction_memory (.A (PCF) ,.RD (RD));

latch0 latch0 (.reset (reset),.RD (RD),.PCSrcd (PCSrcdD),.clk (clk), .instrD (instrD), .StallD (StallD),
 .PCplus4F (PCPlus4F), .PCplus4D (PCPlus4D));

mux2 #(32) mux2_0 (.d0 (PCPlus4F) ,.d1 (PCBranchD), .s (PCSrcdD), .y (pc_prime) );

RegisterFile RegisterFile (.clk (clk),.reset (reset) ,.WE3 (RegWriteW) ,.A1 (instrD[25:21]) ,.A2 (instrD[20:16]) ,
.A3 (WriteRegW) ,.WD3 (ResultW) ,.RD1 (RD1D) ,.RD2 (RD2D) );

mux2 #(32) mux2_1 (.d0 (RD1D) ,.d1 (ALUOutM) ,.s (ForwardAD), .y(a));

mux2 #(32) mux2_2 ( .d0 (RD2D) , .d1 (ALUOutM) , .s (ForwardBD),.y (b));

equald equald (.a (a) ,.b (b) ,.c (EqualD) );

signext signext (.a (instrD[15:0]) ,.sgnzero (sgnzero) ,.y (SignimmD) );

shift_left_2  shift_left_2  (.a (SignimmD) ,.y (SignimmD_shift) );

adder adder_1 (.a (SignimmD_shift) ,.b (PCPlus4D ),.y (PCBranchD));

latch1 latch1 (.reset (reset),.clk (clk) ,.RegWriteD (RegWriteD) ,.MemtoRegD (MemtoRegD) ,.MemWriteD (MemWriteD) ,
.AluControlD (ALUControlD) ,.AluSrcD (ALUsrcD) ,.RegDstD (RegDstD) ,.RegWriteE (RegWriteE) ,.MemtoRegE (MemtoRegE) ,
.MemWriteE (MemWriteE) ,.AluControlE (ALUControlE) ,.AluSrcE (ALUsrcE) ,.RegDstE (RegDstE),.RD1D (RD1D) ,.RD1E (RD1E) ,
.RD2D (RD2D) ,.RD2E (RD2E) ,.RsD (instrD[25:21]) ,.RsE (RsE) ,.RtD (instrD[20:16])  ,.RtE (RtE) ,.RdD (instrD[15:11]) ,
.RdE (RdE) ,.flush (FlushE) ,.SignImmD (SignimmD) ,.SignImmE (SignimmE ));

mux2 #(5) mux2_3 (.d0 (RtE) ,.d1 (RdE) ,.s (RegDstE) ,.y (WriteRegE));

mux3 mux3_0 ( .a (RD1E) ,.b  (ResultW) ,.c (ALUOutM) ,.d (SrcAE) ,.selector (ForwardAE) );

mux3 mux3_1 (.a (RD2E) , .b (ResultW) ,.c (ALUOutM) ,.d (WriteDataE) ,.selector (ForwardBE) );

mux2 #(32) mux2_4 (.d0 (WriteDataE) ,.d1 (SignimmE) ,.s (ALUsrcE) ,.y (SrcBE) );

ALU ALU (.SrcA (SrcAE) ,.SrcB (SrcBE) ,.ALUControl (ALUControlE) ,.ALUResult (ALUOutE) ,.Zero (zero) );

latch2 latch2 (.reset (reset),.clk (clk) ,.RegWriteE (RegWriteE) ,.MemtoRegE (MemtoRegE) ,.MemWriteE (MemWriteE) ,
.RegWriteM (RegWriteM) ,.MemtoRegM (MemtoRegM) ,.MemWriteM (MemWriteM) ,.ALUOutE (ALUOutE) ,.ALUOutM (ALUOutM) ,
.WriteDataE (WriteDataE) ,.WriteDataM (WriteDataM) ,.WriteRegE (WriteRegE) ,.WriteRegM (WriteRegM) );

Data_memory Data_memory (.clk (clk),.MemWrite (MemWriteM)  ,.Address (ALUOutM) ,.WriteData (WriteDataM) ,.ReadData (ReadDataM) );

latch3 latch3 (.reset (reset),.clk (clk) ,.RegWriteM (RegWriteM) ,.MemtoRegM (MemtoRegM) ,.RegWriteW (RegWriteW) ,
.MemtoRegW (MemtoRegW) ,.WriteRegM (WriteRegM) ,.WriteRegW (WriteRegW) ,.ReadDataM (ReadDataM) ,.ReadDataW (ReadDataW) ,
.ALUOutM (ALUOutM) ,.ALUOutW (ALUOutW) );

mux2 #(32) mux2_5 (.d0 (ALUOutW) , .d1 (ReadDataW) ,.s (MemtoRegW) ,.y (ResultW) );
endmodule












 



