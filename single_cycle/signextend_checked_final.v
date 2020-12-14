module signext (imm,extendimm,sgnzero
    );
input sgnzero;
input [15:0] imm;
output [31:0] extendimm ;
assign extendimm=(sgnzero==0)? {{16{1'b0}},imm} :{{16{imm[15]}},imm} ;

endmodule
