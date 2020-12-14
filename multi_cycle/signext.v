module signext(
input  [15:0] a,
input sgnzero,
output [31:0] y
);

wire b = 16'd0;

assign y = sgnzero ? {{16{a[15]}}, a} : {b, a};

endmodule
