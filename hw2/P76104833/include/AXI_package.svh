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


	// define AW,AR for model input
	// AW|AR=ID+`AddrInfo+`HandShake
	`define A(RW,ROLE) \
		A``RW``ID_``ROLE``, \
		A``RW``_``ROLE``, \
		HSA``RW``_``ROLE``

	//define W model input
	// W=`MetaData+`HandShake
	`define W(ROLE) \
		W_``ROLE``, \
		HSW_``ROLE``

	//define R model input
	// R=ID +`MetaData +`HandShake +RESP
	// need add RESP by hane if is for master 
	`define R(ROLE) \
		RID_``ROLE``, \
		R_``ROLE``, \
		HSR_``ROLE``

	//define B model input
	// B=ID +RESP +`Handshake
	`define B(ROLE) \
		BID_``ROLE``, \
		BRESP_``ROLE``, \
		HSAR_``ROLE``

	//create wires
	//create R channel wires
	`define CREATE_R(NAME) \
		wire [`AXI_IDM_BITS-1:0] ARID_``NAME``; \
		AddrInfo AR_``NAME``; \
		HandShake HSAR_``NAME``; \
		wire [`AXI_IDM_BITS-1:0] RID_``NAME``; \
		MetaData R_``NAME``; \
		wire [1:0] RRESP_``NAME``; \
		HandShake HSR_``NAME``;

	//create W channel wires
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


	//create MUX_R

`endif
