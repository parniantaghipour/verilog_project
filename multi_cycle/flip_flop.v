module flopr #(parameter WIDTH=8 )
(input stall,clk,reset,
    input [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q);

    always @(posedge clk, posedge reset)
	begin
    if(reset) 
    q<=0;
	else 
    
    if(stall)
		q <= q;
	else
		q <= d;

     end
endmodule

