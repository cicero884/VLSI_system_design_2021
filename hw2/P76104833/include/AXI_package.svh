`ifndef AXI_PACKAGE_SVH
	`define AXI_PACKAGE_SVH

////`define HandShake_in(TYPE,ROLE) \
////	HandShake HS``TYPE``_``ROLE``; \
////	assign HS``TYPE``_``ROLE``.valid=``TYPE``VALID_``ROLE``; \
////	assign ``TYPE``READY_``ROLE``	=HS``TYPE``_``ROLE``.ready;

////`define HandShake_out(TYPE,ROLE) \
////	HandShake HS``TYPE``_``ROLE``; \
////	assign ``TYPE``VALID_``ROLE``	=HS``TYPE``_``ROLE``.valid; \
////	assign HS``TYPE``_``ROLE``.ready=``TYPE``READY_``ROLE``;

	`define AddrInfo_in(RW,ROLE) \
		AddrInfo A``RW``_``ROLE``; \
		assign A``RW``_``ROLE``.addr	=A``RW``ADDR_``ROLE``; \
		assign A``RW``_``ROLE``.len		=A``RW``LEN_``ROLE``; \
		assign A``RW``_``ROLE``.size	=A``RW``SIZE_``ROLE``; \
		assign A``RW``_``ROLE``.burst	=BurstType'(A``RW``BURST_``ROLE``);

	`define AddrInfo_out(RW,ROLE) \
		AddrInfo A``RW``_``ROLE``; \
		assign A``RW``ADDR_``ROLE`` 	=A``RW``_``ROLE``.addr; \
		assign A``RW``LEN_``ROLE``  	=A``RW``_``ROLE``.len; \
		assign A``RW``SIZE_``ROLE`` 	=A``RW``_``ROLE``.size; \
		assign A``RW``BURST_``ROLE`` 	=BurstType'(A``RW``_``ROLE``.burst);	

	`define Data_in(RW,ROLE) \
		DataInfo ``RW``_``ROLE``; \
		assign ``RW``_``ROLE``.data	=``RW``DATA_``ROLE``; \
		assign ``RW``_``ROLE``.last	=``RW``LAST_``ROLE``; 

	`define Data_out(RW,ROLE) \
		DataInfo ``RW``_``ROLE``; \
		assign ``RW``DATA_``ROLE``=``RW``_``ROLE``.data; \
		assign ``RW``LAST_``ROLE``=``RW``_``ROLE``.last;

	// combine wire to interface/struct
	`define R_in_convert(ROLE) \
		`AddrInfo_in(R,ROLE) \
		`Data_out(R,ROLE)

	`define R_out_convert(ROLE) \
		`AddrInfo_out(R,ROLE) \
		`Data_in(R,ROLE)

	`define W_in_convert(ROLE) \
		`AddrInfo_in(W,ROLE) \
		`Data_in(W,ROLE)
		
	`define W_out_convert(ROLE) \
		`AddrInfo_out(W,ROLE) \
		`Data_out(W,ROLE)

	// create wires
	// create R channel wires
	`define CREATE_R(NAME,ID_BITS) \
		wire [ID_BITS-1:0] ARID_``NAME``; \
		AddrInfo AR_``NAME``; \
		wire ARVALID_``NAME``; \
		wire ARREADY_``NAME``; \
		wire [ID_BITS-1:0] RID_``NAME``; \
		DataInfo R_``NAME``; \
		wire [1:0] RRESP_``NAME``; \
		wire RVALID_``NAME``; \
		wire RREADY_``NAME``;

	// create W channel wires
	`define CREATE_W(NAME,ID_BITS) \
		wire [ID_BITS-1:0] AWID_``NAME``; \
		AddrInfo AW_``NAME``; \
		wire AWVALID_``NAME``; \
		wire AWREADY_``NAME``; \
		DataInfo W_``NAME``; \
		wire [`AXI_STRB_BITS-1:0] WSTRB_``NAME``; \
		wire WVALID_``NAME``; \
		wire WREADY_``NAME``; \
		wire [ID_BITS-1:0] BID_``NAME``; \
		wire [1:0] BRESP_``NAME``; \
		wire BVALID_``NAME``; \
		wire BREADY_``NAME``;
	
	// for empty channels
	`define EMPTY_R(NAME) \
		assign ARVALID_``NAME``=1'b0;

	`define EMPTY_W(NAME) \
		assign AWVALID_``NAME``=1'b0; \
		assign WVALID_``NAME``=1'b0;

	// package channels
	//READ ADDRESS0	=ID +`AddrInfo +`HandShake
	`define AR_in(NAME)	{ARID_``NAME``,AR_``NAME``,ARVALID_``NAME``}
	`define AR_out(NAME) {ARREADY_``NAME``}
	//READ DATA0	=ID +`DataInfo +RESP +`HandShake
	`define R_in(NAME) {RID_``NAME``,R_``NAME``,RRESP_``NAME``,RVALID_``NAME``}
	`define R_out(NAME) {RREADY_``NAME``}
	//WRITE ADDRESS	=ID +`AddrInfo +`HandShake
	//WRITE DATA	=   +`DataInfo +WSTRB +`HandShake
	`define W_in(NAME) {AWID_``NAME``,AW_``NAME``,AWVALID_``NAME``,W_``NAME``,WSTRB_``NAME``,WVALID_``NAME``}
	`define W_out(NAME) {AWREADY_``NAME``,WREADY_``NAME``}
	//WRITE RESPONSE=ID +RESP +`Handshake
	`define B_in(NAME) {BID_``NAME``,BRESP_``NAME``,BVALID_``NAME``}
	`define B_out(NAME) {BREADY_``NAME``}

////// package R_R(Read Request)(ID,AddrInfo,HSAR.valid,HSR.ready)
////`define R_R_channel(NAME) {ARID_``NAME``,AR_``NAME``,HSAR_``NAME``.valid,HSR_``NAME``.ready}
////// package R_B(Read Back)(ID,DataInfo,HSAR.ready,RRESP,HSR.valid)
////`define R_B_channel(NAME) {RID_``NAME``,R_``NAME``,RRESP_``NAME``,HSAR_``NAME``.ready,HSR_``NAME``.valid}
////// package W_R(Write Request)(ID,AddrInfo,HSAW.valid,DataInfo,WSTRB,HSW.valid,HSB.ready)
////`define W_R_channel(NAME) {AWID_``NAME``,AW_``NAME``,HSAW_``NAME``.valid,W_``NAME``,WSTRB_``NAME``,HSW_``NAME``.valid,HSB_``NAME``.ready}
////// package W_B(Write Back)(ID,BRESP,HSB.valid,HSW.ready,HSAW.ready)
////`define W_B_channel(NAME) {BID_``NAME``,BRESP_``NAME``,HSB_``NAME``.valid,HSW_``NAME``.ready,HSAW_``NAME``.ready}

`endif
