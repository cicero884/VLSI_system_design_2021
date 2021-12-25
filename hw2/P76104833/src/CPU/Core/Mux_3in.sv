module Mux_3in
#(parameter size=32)(
	//input
	input [1:0]ctrl,
	input [size-1:0]in0,
	input [size-1:0]in1,
	input [size-1:0]in2,
	//output 
	output logic [size-1:0]out
);

always_comb begin
	case (ctrl)
		2'b00:out=in0;
		2'b01:out=in1;
		2'b10:out=in2;
		2'b11:out=32'dx;
	endcase
end
endmodule
