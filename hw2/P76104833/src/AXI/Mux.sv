// sel is one-hot encoding!
module Mux #(parameter in_size=0,parameter out_size=0,parameter channel=2)(
	input [channel-1:0] sel,
	input [in_size-1:0] one_in,						output logic [out_size-1:0] one_out,
	output logic [in_size-1:0] multi_out[channel],	input [out_size] multi_in[channel]
);

always_comb begin
	one_out = {out_size{1'b0}};
	for (int index = 0; index < channel; index++) begin
		multi_out[index] = {in_size {sel[index]}} & one_in;
		one_out 		|= {out_size{sel[index]}} & multi_in[index];
	end
end
/*
always_comb begin
	out0_out={in_size{1'b0}};
	out1_out={in_size{1'b0}};
	out2_out={in_size{1'b0}};
	case(Pointer'(pointer))
		SEL0:	out0_out=in_in;
		SEL1:	out1_out=in_in;
		default:out2_out=in_in;
	endcase


	case(Pointer'(pointer))
		SEL0:	in_out=out0_in;
		SEL1:	in_out=out1_in;
		default:in_out=out2_in;
	endcase
end
*/
endmodule
