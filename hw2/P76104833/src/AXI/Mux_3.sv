`include "AXI_define.svh"
//interface sucks
//you cant direct assign interface into another interface
module Mux_3 #(parameter in_size,parameter out_size)(
	input logic[`AXI_POINTER_BITS] pointer,
	input  [in_size-1:0]in_in,    output [out_size-1:0]in_out,
	output [in_size-1:0]out0_out, input  [out_size-1:0]out0_in,
	output [in_size-1:0]out1_out, input  [out_size-1:0]out1_in,
	output [in_size-1:0]out2_out, input  [out_size-1:0]out2_in,
);
Pointer p;
assign p=pointer;
always_comb begin
	out0_out={in_size{1'b0}};
	out1_out={in_size{1'b0}};
	out2_out={in_size{1'b0}};
	case(p):
		SEL0:	out0_out=in_in;
		SEL1:	out1_out=in_in;
		default:out2_out=in_in;
	endcase

	case(p):
		SEL0:	in_out=out0_in;
		SEL1:	in_out=out1_in;
		default:in_out=out2_in;
	endcase
end
endmodule
