module ALU(
	input [31:0] SrcA, 
    input [31:0] SrcB, 
    input [2:0] ALUControl, 
    output reg [31:0] ALUResult, 
    output Zero);
	
   wire sub_flag = (ALUControl == 3'b000) ? 0:1;
   wire [31:0] B_prime = (sub_flag == 1) ? (~SrcB):(SrcB);
   wire [32:0] sum = SrcA + B_prime + sub_flag;
   wire sltu = ! sum[32];
   wire v = (sub_flag == 1) ? (SrcA[31] != SrcB[31] && SrcA[31] != sum[31]) : (SrcA[31] == SrcB[31] && SrcA[31] != sum[31]);
   wire slt = v ^ sum[31];
   reg [31:0] Result;
   always @(*)
      case(ALUControl)
         3'b000 : ALUResult = sum;
         3'b001 : ALUResult = sum;
         3'b010 : ALUResult = SrcA & SrcB;
         3'b011 : ALUResult = SrcA | SrcB;
         3'b100 : ALUResult = SrcA ^ SrcB;
         3'b101 : ALUResult = ~(SrcA | SrcB);
         3'b110 : ALUResult = slt;
         3'b111 : ALUResult = sltu;
      endcase
   assign  Zero = (ALUResult == 32'h00000000)? 1:0;    
endmodule
	

		
	
	


