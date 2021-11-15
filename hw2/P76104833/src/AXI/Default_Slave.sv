`include "AXI_define.svh"
`include "AXI_wrapper.svh"

module Default_Slave(
	input clk, input rst,
	input [`AXI_IDS_BITS]ARID_S, AddrInfo

	HandShake.in HSAR_SD, HandShake.in HSAW_SD, HandShake.in HSW_SD,
	HandShake.out HSR_SD, HandShake.out HSB_SD,
	output [1:0]logic RRESP_SD, output [1:0]logic BRESP_SD
)

`EMPTY_R()
`EMPTY_W()

// Read handler
Responce RRESP;
assign RRESP=DECERR;
assign RRESP_SD=RRESP;
assign BRESP_SD=RRESP;

State read_state;

always_comb begin
	if(read_state==IDLE && HSAR_SD.valid) read_state=TRANSMITTING;
	if(read_state==TRANSMITTING && )
end

always_ff() begin
	
end

// Write handler
endmodule
