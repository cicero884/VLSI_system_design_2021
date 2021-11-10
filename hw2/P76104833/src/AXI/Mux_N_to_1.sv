`include "AXI_define.svh"
//interface sucks
//you cant direct assign interface into another interface
module MUX_N_to_1 #(parameter SIZE=1)(
	input [SIZE-1:0]in1,input [SIZE-1:0]in2,input [SIZE-1:0]in_default,
	output Pointer cond,output [SIZE-1:0]out
)
always_comb begin
	case(cond):
		SEL1:	out=in1;
		SEL2:	out=in2;
		default:out=in_default;
	endcase
end
endmodule
