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
	output reg SgnZero);

	always@(*)
	begin
		if(Op == 6'b0)
			begin
				case(Funct)
					6'b100000,6'b100001: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl} = 9'b000011000;	//add,addu
					6'b100010,6'b100011: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl} = 9'b000011001; 	//sub,subu
					6'b100100: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl} = 9'b000011010;  			//and
					6'b100101: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl} = 9'b000011011;			//or
					6'b100110: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl} = 9'b000011100; 			//xor
					6'b100111: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl} = 9'b000011101;		    //nor
					6'b101010: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl} = 9'b000011110;  			//slt
					6'b101011: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, ALUControl} = 9'b000011111;		 	//sltu
				endcase
			end
		else
		begin
			case(Op)
				6'b100011: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl} = 10'b1001011000;		//lw
				6'b101011: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl} = 10'b0101001000; 	//sw
				6'b000100:  //beq
					begin
						{MemtoReg, MemWrite, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl} = 9'b000001001;
						PCSrc = Zero;
					end
				6'b000101:  //bne
					begin
						{MemtoReg, MemWrite, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl} = 9'b000001001;
						PCSrc = ~Zero;
					end
				6'b001100: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl} = 10'b0001010010; 	//andi
				6'b001101: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl} = 10'b0001010011;		//ori
				6'b001110: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl} = 10'b0001010100;  	//xori
				6'b001000,6'b001001: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl} = 10'b0001011000;  //addi,addiu
				6'b001010: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl} = 10'b0001011110;  	//slti
				6'b001001: {MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, ALUControl} = 10'b0010100111; 	//sltiu
			endcase
		end
	end
endmodule