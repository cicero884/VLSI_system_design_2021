`ifndef AXI_PACKAGE_SVH
	`define AXI_PACKAGE_SVH

	// connect wire to interface/struct
	`define HandShake_prepare(TYPE,ROLE) \
		HandShake HS``TYPE``_``ROLE``(); \
		HS``TYPE``_``ROLE``.ready=``TYPE``READY_``ROLE`` \
		HS``TYPE``_``ROLE``.valid=``TYPE``VALID_``ROLE`` 

	`define AddrInfo_prepare(RW,ROLE) \
		AddrInfo A``RW``_``ROLE``(); \
		A``RW``_``ROLE``.addr	=A``RW``ADDR_``ROLE``; \
		A``RW``_``ROLE``.len	=A``RW``LEN_``ROLE``; \
		A``RW``_``ROLE``.size	=A``RW``SIZE_``ROLE``; \
		A``RW``_``ROLE``.burst	=A``RW``BURST_``ROLE``;

	`define MetaData_prepare(RW,ROLE) \
		MetaData ``RW``_``ROLE``(); \
		``RW``_``ROLE``.data	=``RW``DATA_``ROLE``; \
		``RW``_``ROLE``.last	=``RW``LAST_``ROLE``; 

	// create wires
	// create R channel wires
	`define CREATE_R(NAME) \
		wire [`AXI_IDM_BITS-1:0] ARID_``NAME``; \
		AddrInfo AR_``NAME``; \
		HandShake HSAR_``NAME``; \
		wire [`AXI_IDM_BITS-1:0] RID_``NAME``; \
		MetaData R_``NAME``; \
		wire [1:0] RRESP_``NAME``; \
		HandShake HSR_``NAME``;

	// create W channel wires
	`define CREATE_W(NAME) \
		wire [`AXI_IDS_BITS-1:0] AWID_``NAME``; \
		AddrInfo AW_``NAME``; \
		HandShake HSAW_``NAME``; \
		MetaData W_``NAME``; \
		wire [`AXI_STRB_BITS-1:0] WSTRB_``NAME``; \
		HandShake HSW_``NAME``; \
		wire [`AXI_IDS_BITS-1:0] BID_``NAME``; \
		wire [1:0] BRESP_``NAME``; \
		HandShake HSB_``NAME``;
	
	// for empty channels
	`define EMPTY_R(NAME) \
		assign HSAR_``NAME``.valid=1'b0;
	`define EMPTY_W(NAME) \
		assign HSAW_``NAME``.valid=1'b0; \
		assign HSW_``NAME``.valid=1'b0;

	// package same direction
	// package R_R(Read Request)(ID,AddrInfo,HSAR.valid,HSR.ready)
	`define R_R_channel(NAME) {ARID_``NAME``,AR_``NAME``,HSAR_``NAME``.valid,HSR_``NAME``.ready}
	// package R_B(Read Back)(ID,MetaData,HSAR.ready,RRESP,HSR.valid)
	`define R_B_channel(NAME) {RID_``NAME``,R_``NAME``,RRESP_``NAME``,HSR_``NAME``.valid,HSR_``NAME``.ready}
	// package W_R(Write Request)(ID,AddrInfo,HSAW.valid,MetaData,WSTRB,HSW.valid,HSB.ready)
	`define W_R_channel(NAME) {AWID_``NAME``,AW_``NAME``,HSAW_``NAME``.valid,W_``NAME``,WSTRB_``NAME``,HSW_``NAME``.valid,HSB_``NAME``.ready}
	// package W_B(Write Back)(ID,BRESP,HSB.valid,HSW.ready,HSAW.ready)
	`define W_B_channel(NAME) {BID_``NAME``,BRESP_``NAME``,HSB_``NAME``.valid,HSW_``NAME``.ready,HSAW_``NAME``.ready}

`endif
