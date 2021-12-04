`include "AXI_define.svh"
`define RANGE(START,END) ((addr>=START)&&(addr<END))

module Decoder(
	input [`AXI_ADDR_BITS-1:0]addr,
	output logic[`AXI_SLAVE_CNT-1:0] direction
);
always_comb begin
	if(		`RANGE(32'h00000000,32'h00010000)) direction={`AXI_SLAVE_CNT'd1}<<0;
	else if(`RANGE(32'h00010000,32'h00020000)) direction={`AXI_SLAVE_CNT'd1}<<1;
	else direction={`AXI_SLAVE_CNT'd1}<<2;
end

endmodule
