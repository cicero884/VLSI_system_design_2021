`include "AXI_define.svh"
//interface sucks
//you cant direct assign interface into another interface
module MUX_1_to_N #(SIZE=1)(
	input [SIZE-1:0]in,input OutPointer cond,
	output [SIZE-1:0]out1,output [SIZE-1:0]out2,output [SIZE-1:0]out_default
)
always_comb begin
	out1=0;
	out2=0;
	out_default=0;
	case(cond):
		IN1:	out1		=in;
		IN2:	out2		=in;
		default:out_defaulti=in;
	endcase
end
endmodule
