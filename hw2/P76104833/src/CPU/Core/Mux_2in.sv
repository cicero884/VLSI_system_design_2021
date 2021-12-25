module Mux_2in
#(parameter size=32)(
	//input
	input ctrl,
	input [size-1:0]in0,
	input [size-1:0]in1,
	//output
	output [size-1:0]out
);

assign out=ctrl? in1:in0;

endmodule
