`include "AXI_define.svh"
//interface sucks
//you cant direct assign interface into another interface
module MUX_1_to_3 #(parameter SIZE=1)(
	input [SIZE-1:0]in,input Pointer cond,
	output [SIZE-1:0]out1,output [SIZE-1:0]out2,output [SIZE-1:0]out_default
)
always_comb begin
	out1={SIZE{1'b0}};
	out2={SIZE{1'b0}};
	out_default={SIZE{1'b0}};
	
	case(cond):
		SEL1:	out1		=in;
		SEL2:	out2		=in;
		default:out_defaulti=in;
	endcase
end
endmodule
