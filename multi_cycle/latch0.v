module latch0(reset,RD,PCSrcd,clk,instrD,StallD,PCplus4F,PCplus4D);
input [31:0]RD , PCplus4F;
input PCSrcd,clk,StallD,reset;
output reg [31:0] instrD , PCplus4D;
// always @ (posedge clk)
// 	begin
// 		if (reset || StallD)
// 			begin
// 				instrD<=32'h00000000;
//  				PCplus4D <= 32'h00000000;
// 			end
// 		else
// 			begin
// 				if(PCSrcd)
// 					begin
// 					instrD<=RD;
// 					PCplus4D<=PCplus4F;
// 					end
// 				else
// 					begin
// 					instrD<=instrD;
// 					PCplus4D<=PCplus4D;
// 					end

// 			end
// 	end
// endmodule
always @ (posedge clk)
	begin
		if(reset)
		begin
			instrD<=32'h00000000;
			PCplus4D <= 32'h00000000;
		end
		else
		if(!StallD && !PCSrcd)
		begin
			instrD<=RD;
			PCplus4D<=PCplus4F;	
		end
		else
		if(StallD)
		begin
			instrD<=instrD;
			PCplus4D<=PCplus4D;
		end
		else
		if(PCSrcd)
		begin
			instrD<=32'h00000000;
			PCplus4D <= 32'h00000000;
		end
	end
endmodule





// module latch0(reset,RD,PCSrcd,clk,instrD,StallD,PCplus4F,PCplus4D);
// input [31:0]RD , PCplus4F;
// input PCSrcd,clk,StallD,reset;
// output reg [31:0] instrD , PCplus4D;
// always @ (posedge clk,reset)
// 	begin
// 		if( reset||StallD )
// 		begin
// 			instrD <= {32{1'b0}};
// 			PCplus4D <= {32{1'b0}};
// 		end
// 		else
// 		case(PCSrcd)
// 					1'b0: begin
// 						instrD <= RD ;
// 						PCplus4D <= PCplus4F; 
// 						end
// 					1'b1: begin
// 						instrD <= instrD ;
// 						PCplus4D <= PCplus4D ; 
// 						end				
// 				endcase
// 	end
// endmodule
