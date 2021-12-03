`ifndef AXI_PACKAGE_SVH
	`define AXI_PACKAGE_SVH

	// convert struct
////`define AddrInfo_in(RW,ROLE,NAME) \
////	assign A``RW``_``NAME``.addr	=A``RW``ADDR_``ROLE``; \
////	assign A``RW``_``NAME``.len		=A``RW``LEN_``ROLE``; \
////	assign A``RW``_``NAME``.size	=A``RW``SIZE_``ROLE``; \
////	assign A``RW``_``NAME``.burst	=BurstType'(A``RW``BURST_``ROLE``);

////`define AddrInfo_out(RW,ROLE,NAME) \
////	assign A``RW``ADDR_``ROLE`` 	=A``RW``_``NAME``.addr; \
////	assign A``RW``LEN_``ROLE``  	=A``RW``_``NAME``.len; \
////	assign A``RW``SIZE_``ROLE`` 	=A``RW``_``NAME``.size; \
////	assign A``RW``BURST_``ROLE`` 	=BurstType'(A``RW``_``NAME``.burst);	

////`define Data_in(RW,ROLE,NAME) \
////	assign ``RW``_``NAME``.data	=``RW``DATA_``ROLE``; \
////	assign ``RW``_``NAME``.last	=``RW``LAST_``ROLE``; 

////`define Data_out(RW,ROLE,NAME) \
////	assign ``RW``DATA_``ROLE``=``RW``_``NAME``.data; \
////	assign ``RW``LAST_``ROLE``=``RW``_``NAME``.last;

////// convert all wire
////`define R_in_convert(ROLE,NAME) \
////	assign ARID_``NAME``=ARID_``ROLE``; \
////	`AddrInfo_in(R,ROLE,NAME) \
////	assign ARVALID_``NAME``=ARVALID_``ROLE``; \
////	assign ARREADY_``ROLE``=ARREADY_``NAME``; \
////	assign RID_
////	`Data_out(R,ROLE,NAME) \
////	assign RVALID_``NAME``=RVALID_``ROLE``; \
////	assign RREADY_``ROLE``=RREADY_``NAME``; \
////	assign 

////`define R_out_convert(ROLE,NAME) \
////	`AddrInfo_out(R,ROLE,NAME) \
////	`Data_in(R,ROLE,NAME)

////`define W_in_convert(ROLE,NAME) \
////	`AddrInfo_in(W,ROLE,NAME) \
////	`Data_in(W,ROLE,NAME)
////	
////`define W_out_convert(ROLE,NAME) \
////	`AddrInfo_out(W,ROLE,NAME) \
////	`Data_out(W,ROLE,NAME)

	// create wires
	`define CREATE_R(NAME,ID_BITS) \
		wire [ID_BITS-1:0] ARID_``NAME``; \
		wire [`AXI_ADDR_BITS-1:0] ARADDR_M0, \
		wire [`AXI_LEN_BITS-1:0] ARLEN_M0, \
		wire [`AXI_SIZE_BITS-1:0] ARSIZE_M0, \
		wire [1:0] ARBURST_M0, \
		wire ARVALID_``NAME``; \
		wire ARREADY_``NAME``; \
		wire [ID_BITS-1:0] RID_``NAME``; \
		wire [`AXI_DATA_BITS-1:0] RDATA_``NAME``; \
		wire [1:0] RRESP_``NAME``; \
		wire RLAST_``NAME``; \
		wire RVALID_``NAME``; \
		wire RREADY_``NAME``;

	`define CREATE_W(NAME,ID_BITS) \
		wire [ID_BITS-1:0] AWID_``NAME``; \
		wire [`AXI_ADDR_BITS-1:0] AWADDR_M0, \
		wire [`AXI_LEN_BITS-1:0] AWLEN_M0, \
		wire [`AXI_SIZE_BITS-1:0] AWSIZE_M0, \
		wire [1:0] AWBURST_M0, \
		wire AWVALID_``NAME``; \
		wire AWREADY_``NAME``; \
		wire [`AXI_DATA_BITS-1:0] WDATA_``NAME``; \
		wire [`AXI_STRB_BITS-1:0] WSTRB_``NAME``; \
		wire WLAST_``NAME``; \
		wire WVALID_``NAME``; \
		wire WREADY_``NAME``; \
		wire [ID_BITS-1:0] BID_``NAME``; \
		wire [1:0] BRESP_``NAME``; \
		wire BVALID_``NAME``; \
		wire BREADY_``NAME``;
	
	// for empty channels
	// TODO: in and out?
	`define EMPTY_R(NAME) \
		assign ARVALID_``NAME``=1'b0;

	`define EMPTY_W(NAME) \
		assign AWVALID_``NAME``=1'b0; \
		assign WVALID_``NAME``=1'b0;


	// package channels
	// READ ADDRESS0	=ID +`AddrInfo +`HandShake
	`define AR_in(NAME)	{ARID_``NAME``[`AXI_IDM_BITS-1:0],ARADDR_``NAME``,ARLEN_``NAME``,ARSIZE_``NAME``,ARBUST_``NAME``,ARVALID_``NAME``}
	`define AR_out(NAME) {ARREADY_``NAME``}

	// READ DATA0	=ID +`DataInfo +RESP +`HandShake
	`define R_in(NAME) {RID_``NAME``[`AXI_IDM_BITS-1:0],RDATA_``NAME``,RRESP_``NAME``,RLAST_``NAME``,RVALID_``NAME``}
	`define R_out(NAME) {RREADY_``NAME``}

	// WRITE ADDRESS	=ID +`AddrInfo +`HandShake
	// WRITE DATA	=   +`DataInfo +WSTRB +`HandShake
	`define W_in(NAME) {AWID_``NAME``[`AXI_IDM_BITS-1:0],AWADDR_``NAME``,AWLEN_``NAME``,AWSIZE_``NAME``,AWBURST_``NAME``,AWVALID_``NAME``,WDATA_``NAME``,WSTRB_``NAME``,WLAST_``NAME``,WVALID_``NAME``}
	`define W_out(NAME) {AWREADY_``NAME``,WREADY_``NAME``}

	// WRITE RESPONSE=ID +RESP +`Handshake
	`define B_in(NAME) {BID_``NAME``[`AXI_IDM_BITS-1:0],BRESP_``NAME``,BVALID_``NAME``}
	`define B_out(NAME) {BREADY_``NAME``}

	// connect wires
`endif
