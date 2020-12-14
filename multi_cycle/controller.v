module controller(
	input [5:0]Op,
	input [5:0]Funct,
	input Zero,
	output reg MemtoReg,
	output reg MemWrite,
	output reg PCSrc,
	output reg [2:0] ALUControl,
	output reg ALUSrc,
	output reg RegDst,
	output reg RegWrite,
	output reg SgnZero ,
	output reg branch);

	always@(*)
	begin
		if(Op == 6'b0)
			begin
				case(Funct)
					6'b100000,6'b100001: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl,branch} = 10'b0000110000;	//add,addu
					6'b100010,6'b100011: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl, branch} = 10'b0000110010; 	//sub,subu
					6'b100100: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl,branch} = 10'b0000110100;  			//and
					6'b100101: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl,branch} = 10'b0000110110;			//or
					6'b100110: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl,branch} = 10'b0000111000; 			//xor
					6'b100111: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl,branch} = 10'b0000111010;		    //nor
					6'b101010: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl,branch} = 10'b0000111100;  			//slt
					6'b101011: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl,branch} = 10'b0000111110;		 	//sltu
					default : {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl, branch} = 10'b0000000000;				// nothing
				endcase
			end
		else
		begin
			case(Op)
				6'b100011: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl,branch} = 11'b10010110000;		//lw
				6'b101011: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl,branch} = 11'b01010010000; 	//sw
				6'b000100:  //beq
					begin
						{MemtoReg, MemWrite, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl,branch} = 10'b0000010011;
						PCSrc = Zero;
					end
				6'b000101:  //bne
					begin
						{MemtoReg, MemWrite, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl,branch} = 10'b0000010011;
						PCSrc = ~Zero;
					end
				6'b001100: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl,branch} = 11'b00010100100; 	//andi
				6'b001101: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl,branch} = 11'b00010100110;		//ori
				6'b001110: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl,branch} = 11'b00010101000;  	//xori
				6'b001000,6'b001001: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl,branch} = 11'b00010110000;  //addi,addiu
				6'b001010: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl,branch} = 11'b00010111100;  	//slti
				6'b001001: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl,branch} = 11'b00101001110; 	//sltiu
			endcase
		end
	end
endmodule