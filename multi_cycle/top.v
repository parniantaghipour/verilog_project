module top_module(
input clk, reset
);
wire [31:0] instrD ;
wire EqualD , memtoreg , memwrite , pcsrc , alusrc , regdst , regwrite, sgnzero ;
wire [2:0] alucontrol;
wire [4:0] RsE , RtE , WriteRegE , WriteRegM ,WriteRegW;
wire stallF , stallD , flushE , forwardAD , forwardBD ;
wire [1:0] forwardAE , forwardBE ;
wire RegWriteM , RegWriteW , MemtoRegE , branch ;

controller controller (.Op (instrD[31:26]) , .Funct(instrD[5:0]) , .Zero(EqualD) ,.MemtoReg( memtoreg ),.MemWrite( memwrite ),
.PCSrc (pcsrc) ,.ALUControl(alucontrol),.ALUSrc (alusrc) ,.RegDst (regdst) ,.RegWrite (regwrite),.SgnZero (sgnzero) ,.branch (branch));

hazard hazard (. RsE (RsE) ,.RtE (RtE) ,.WriteRegE (WriteRegE) ,.WriteRegM (WriteRegM) ,.RsD (instrD[25:21]) , .RtD (instrD[20:16]) ,
.stallF (stallF) ,.stallD (stallD) ,.flushE (flushE) ,.forwardAD (forwardAD) ,.forwardBD (forwardBD) ,.forwardAE (forwardAE) ,
.forwardBE (forwardBE) ,.RegWriteM (RegWriteM) ,.RegWriteW (RegWriteW) ,.MemtoRegE (MemtoRegE) ,.WriteRegW (WriteRegW) ,
.PCsrcD (branch) ,.RegWriteE (RegWriteE) ,.MemtoRegM(MemtoRegM));

datapath datapath (.clk (clk),.reset (reset),.RegWriteD (regwrite),.MemtoRegD (memtoreg) ,.MemWriteD (memwrite) ,
.ALUControlD (alucontrol) ,.ALUsrcD (alusrc) ,.RegDstD (regdst) ,.PCSrcdD (pcsrc),.sgnzero (sgnzero) ,.StallF (stallF) ,
.StallD (stallD) ,.ForwardAD (forwardAD) ,.ForwardBD (forwardBD) ,.FlushE (flushE) ,.ForwardAE (forwardAE) ,.ForwardBE (forwardBE) ,
.EqualD (EqualD) ,.instrD (instrD) ,.RegWriteM  (RegWriteM) ,.RegWriteW (RegWriteW) ,.RegWriteE (RegWriteE),.MemtoRegE (MemtoRegE) ,
.MemtoRegM (MemtoRegM),.WriteRegE (WriteRegE) ,.WriteRegM (WriteRegM) ,.WriteRegW (WriteRegW) ,.RsE (RsE),.RtE (RtE)  );

endmodule