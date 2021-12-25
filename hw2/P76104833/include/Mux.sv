// sel is one-hot encoding
// multi=>{arr[2],arr[1],arr[0]}
module Mux #(parameter IN_SIZE=0,parameter OUT_SIZE=0,parameter CHANNEL=2)(
	input [IN_SIZE-1:0] one_in,						output logic [OUT_SIZE-1:0] one_out,
	output logic [CHANNEL-1:0][IN_SIZE-1:0] multi_out,	input [CHANNEL-1:0][OUT_SIZE-1:0] multi_in,
	input [CHANNEL-1:0] sel
);

always_comb begin
	one_out = {OUT_SIZE{1'b0}};
	for (int index = 0; index < CHANNEL; index++) begin
		multi_out[index] = {IN_SIZE {sel[index]}} & one_in;
		one_out 		|= {OUT_SIZE{sel[index]}} & multi_in[index];
	end
end
endmodule
