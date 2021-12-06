`ifndef AXI_PACKAGE_SVH
	`define AXI_PACKAGE_SVH
	// create wires
	`define CREATE_R(NAME,ID_BITS) \
		wire [ID_BITS-1:0] ARID_``NAME``; \
		wire [`AXI_ADDR_BITS-1:0] ARADDR_``NAME``; \
		wire [`AXI_LEN_BITS-1:0] ARLEN_``NAME``; \
		wire [`AXI_SIZE_BITS-1:0] ARSIZE_``NAME``; \
		wire [1:0] ARBURST_``NAME``; \
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
		wire [`AXI_ADDR_BITS-1:0] AWADDR_``NAME``; \
		wire [`AXI_LEN_BITS-1:0] AWLEN_``NAME``; \
		wire [`AXI_SIZE_BITS-1:0] AWSIZE_``NAME``; \
		wire [1:0] AWBURST_``NAME``; \
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
	`define AR_in(NAME)	{ARID_``NAME``[`AXI_IDM_BITS-1:0],ARADDR_``NAME``,ARLEN_``NAME``,ARSIZE_``NAME``,ARBURST_``NAME``,ARVALID_``NAME``}
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

	// package as array
	// TODO:need be add by hand if increase `AXI_SLAVE_CNT :L
	`define TO_MULTI_3(TYPE,NAME) {`TYPE(NAME[2]),`TYPE(NAME[1]),`TYPE(NAME[0])}

	// connect all wires
	`define CONNECT_R(NAME1,NAME2) \
		assign `AR_in(NAME1)=`AR_in(NAME2); \
		assign `AR_out(NAME2)=`AR_out(NAME1); \
		assign `R_in(NAME2)=`R_in(NAME1); \
		assign `R_out(NAME1)=`R_out(NAME2);

	`define CONNECT_W(NAME1,NAME2) \
		assign `W_in(NAME1)=`W_in(NAME2); \
		assign `W_out(NAME2)=`W_out(NAME1); \
		assign `B_in(NAME2)=`B_in(NAME1); \
		assign `B_out(NAME1)=`B_out(NAME2);

`endif
