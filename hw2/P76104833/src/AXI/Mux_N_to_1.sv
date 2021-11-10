`include "AXI_define.svh"
//interface sucks
//you cant direct assign interface into another interface
module MUX_N_to_1 (#SIZE=1)
(input [SIZE-1:0]in1,input [SIZE-1:0]in2,input [SIZE-1:0]in_default
,output OutPointer cond,output [SIZE-1:0]out)
COND,OUTPUT)
always_comb begin
	case(cond):
		IN1:	out=in1;
		IN2:	out=in2;
		default:out=in_default;
	endcase
end
endmodule
