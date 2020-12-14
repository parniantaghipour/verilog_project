module datapath(input clk,reset,
input memtoreg,pcsrc,
input alusrc,regdst,
input regwrite,
input sgnzero,
input [2:0] alucontrol,
output zero,
output [31:0] pc,
input [31:0] instr,
output [31:0] aluout,writedata,
input [31:0] readdata
);
wire [4:0] writereg;
wire [31:0] pcnext,pcnextbr,pcplus4,pcbranch;
wire [31:0] signimm,signimmsh;
wire [31:0] srca,srcb;
wire [31:0] result;

flopr #(32) pcreg(clk,reset,pcnext,pc);

adder pcadd1(pc,32'b100,pcplus4);

adder pcadd2(pcplus4,signimmsh,pcbranch);

sl2 immsh(signimm,signimmsh);

mux2 #(32) pcbrmux(pcplus4 ,pcbranch,pcsrc,pcnext);

regfile rf(clk,regwrite,instr[25:21],
    instr[20:16],writereg,result,srca,writedata);

    mux2 #(5) wrmux(instr[20:16],instr[15:11], regdst,writereg);
    
    mux2 #(32) resmux(aluout,readdata,memtoreg,result);

    signext se(instr[15:0],signimm,sgnzero);

    mux2 #(32) srcbmux(writedata,signimm,alusrc,srcb);

    alu alu_instance(srca,srcb,alucontrol,aluout,zero);

endmodule