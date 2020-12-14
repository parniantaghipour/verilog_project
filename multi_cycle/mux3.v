module mux3 (a,b,c,d,selector);
input [31:0] a, b , c;
output [31:0] d;
input [1:0] selector;
assign d = (selector == 2'b00)? a :
		(selector == 2'b01)? b :
		(selector == 2'b10)? c : {{32{1'b0}}};
endmodule
