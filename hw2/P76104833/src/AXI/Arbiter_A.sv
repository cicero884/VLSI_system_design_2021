`include "AXI_define.svh"
`define true 1'b1
`define false 1'b0
module Arbiter_A(
	input ACLK, input ARESETn,
	//`A(R,M0),
	input [`AXI_IDM_BITS-1:0] ARID_M0, AddrInfo.in AR_M0, HandShake.in HSAR_M0,
	//`A(W,M1),`A(R,M1),`W(M1),
	input [`AXI_IDM_BITS-1:0] AWID_M1, AddrInfo.in AW_M1, HandShake.in HSAW_M1,
	input [`AXI_IDM_BITS-1:0] ARID_M1, AddrInfo.in AR_M1, HandShake.in HSAR_M1,
	MetaData.in W_M1, HandShake.in HSW_M1,
	//`A(W,S0),`A(R,S0),`W(S0)
	output [`AXI_IDM_BITS-1:0] AWID_S, AddrInfo.out AW_S, HandShake.out HSAW_S,
	output [`AXI_IDM_BITS-1:0] ARID_S, AddrInfo.out AR_S, HandShake.out HSAR_S,
	MetaData.out W_S, HandShake.out HSW_S
);
logic sending
always_ff(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		sending<=false;
	end
	else if(!sending) begin
		if()
	end
end

endmodule
