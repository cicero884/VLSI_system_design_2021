// sel is one-hot encoding
// multi=>{arr[2],arr[1],arr[0]}
module Mux #(parameter in_size=0,parameter out_size=0,parameter channel=2)(
	input [in_size-1:0] one_in,						output logic [out_size-1:0] one_out,
	output logic [channel-1:0][in_size-1:0] multi_out,	input [channel-1:0][out_size-1:0] multi_in,
	input [channel-1:0] sel
);

always_comb begin
	one_out = {out_size{1'b0}};
	for (int index = 0; index < channel; index++) begin
		multi_out[index] = {in_size {sel[index]}} & one_in;
		one_out 		|= {out_size{sel[index]}} & multi_in[index];
	end
end
endmodule
