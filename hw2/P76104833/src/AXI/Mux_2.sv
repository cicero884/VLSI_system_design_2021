`include "AXI_define.svh"
//interface sucks
//you cant direct assign interface into another interface
module Mux_2 #(parameter in_size=1,parameter out_size=1)(
	input [`AXI_POINTER_BITS-1:0] pointer,
	input  [in_size-1:0]in_in,    output logic [out_size-1:0]in_out,
	output logic [in_size-1:0]out0_out, input  [out_size-1:0]out0_in,
	output logic [in_size-1:0]out1_out, input  [out_size-1:0]out1_in
);
always_comb begin
	out0_out={in_size{1'b0}};
	out1_out={in_size{1'b0}};
	
	case(Pointer'(pointer))
		SEL0:	out0_out=in_in;
		SEL1:	out1_out=in_in;
	endcase

	case(Pointer'(pointer))
		SEL0:	in_out=out0_in;
		SEL1:	in_out=out1_in;
	endcase
end
endmodule
