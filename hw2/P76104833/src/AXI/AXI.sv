//================================================
// Auther:      Chen Tsung-Chi (Michael)           
// Filename:    AXI.sv                            
// Description: Top module of AXI                  
// Version:     1.0 
//================================================
`include "AXI_define.svh"
`include "Arbiter.sv"
`include "Decoder.sv"

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


module AXI(

	input ACLK,
	input ARESETn,

	//SLAVE INTERFACE FOR MASTERS
	//WRITE ADDRESS	=ID +`AddrInfo +`HandShake
	input [`AXI_IDM_BITS-1:0] AWID_M1,
	input [`AXI_ADDR_BITS-1:0] AWADDR_M1, in interfac
	input [`AXI_LEN_BITS-1:0] AWLEN_M1,
	input [`AXI_SIZE_BITS-1:0] AWSIZE_M1,
	input [1:0] AWBURST_M1,
	input AWVALID_M1,
	output AWREADY_M1,
	//WRITE DATA	=   +`MetaData +`HandShake
	input [`AXI_DATA_BITS-1:0] WDATA_M1,
	input [`AXI_STRB_BITS-1:0] WSTRB_M1,
	input WLAST_M1,
	input WVALID_M1,
	output WREADY_M1,
	//WRITE RESPONSE=ID +RESP +`Handshake
	output [`AXI_IDM_BITS-1:0] BID_M1,
	output [1:0] BRESP_M1,
	output BVALID_M1,
	input BREADY_M1,

	//READ ADDRESS0	=ID +`AddrInfo +`HandShake
	input [`AXI_IDM_BITS-1:0] ARID_M0,
	input [`AXI_ADDR_BITS-1:0] ARADDR_M0,
	input [`AXI_LEN_BITS-1:0] ARLEN_M0,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_M0,
	input [1:0] ARBURST_M0,
	input ARVALID_M0,
	output ARREADY_M0,
	//READ DATA0	=ID +`MetaData +`HandShake +RESP
	output [`AXI_IDM_BITS-1:0] RID_M0,
	output [`AXI_DATA_BITS-1:0] RDATA_M0,
	output [1:0] RRESP_M0,
	output RLAST_M0,
	output RVALID_M0,
	input RREADY_M0,
	//READ ADDRESS1	=ID +`AddrInfo +`HandShake
	input [`AXI_IDM_BITS-1:0] ARID_M1,
	input [`AXI_ADDR_BITS-1:0] ARADDR_M1,
	input [`AXI_LEN_BITS-1:0] ARLEN_M1,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_M1,
	input [1:0] ARBURST_M1,
	input ARVALID_M1,
	output ARREADY_M1,
	//READ DATA1	=ID +`MetaData +`HandShake +RESP
	output [`AXI_IDM_BITS-1:0] RID_M1,
	output [`AXI_DATA_BITS-1:0] RDATA_M1,
	output [1:0] RRESP_M1,
	output RLAST_M1,
	output RVALID_M1,
	input RREADY_M1,

	//MASTER INTERFACE FOR SLAVES
	//WRITE ADDRESS0=ID +`AddrInfo +`HandShake
	output [`AXI_IDS_BITS-1:0] AWID_S0,
	output [`AXI_ADDR_BITS-1:0] AWADDR_S0,
	output [`AXI_LEN_BITS-1:0] AWLEN_S0,
	output [`AXI_SIZE_BITS-1:0] AWSIZE_S0,
	output [1:0] AWBURST_S0,
	output AWVALID_S0,
	input AWREADY_S0,
	//WRITE DATA0	=   +`MetaData +`HandShake
	output [`AXI_DATA_BITS-1:0] WDATA_S0,
	output [`AXI_STRB_BITS-1:0] WSTRB_S0,
	output WLAST_S0,
	output WVALID_S0,
	input WREADY_S0,
	//WRITE RESPONSE0=ID +RESP +`Handshake
	input [`AXI_IDS_BITS-1:0] BID_S0,
	input [1:0] BRESP_S0,
	input BVALID_S0,
	output BREADY_S0,
	
	//WRITE ADDRESS1=ID +`AddrInfo +`HandShake
	output [`AXI_IDS_BITS-1:0] AWID_S1,
	output [`AXI_ADDR_BITS-1:0] AWADDR_S1,
	output [`AXI_LEN_BITS-1:0] AWLEN_S1,
	output [`AXI_SIZE_BITS-1:0] AWSIZE_S1,
	output [1:0] AWBURST_S1,
	output AWVALID_S1,
	input AWREADY_S1,
	//WRITE DATA1	=   +`MetaData +`HandShake
	output [`AXI_DATA_BITS-1:0] WDATA_S1,
	output [`AXI_STRB_BITS-1:0] WSTRB_S1,
	output WLAST_S1,
	output WVALID_S1,
	input WREADY_S1,
	//WRITE RESPONSE1=ID +RESP +`Handshake
	input [`AXI_IDS_BITS-1:0] BID_S1,
	input [1:0] BRESP_S1,
	input BVALID_S1,
	output BREADY_S1,
	
	//READ ADDRESS0	=ID +`AddrInfo +`HandShake
	output [`AXI_IDS_BITS-1:0] ARID_S0,
	output [`AXI_ADDR_BITS-1:0] ARADDR_S0,
	output [`AXI_LEN_BITS-1:0] ARLEN_S0,
	output [`AXI_SIZE_BITS-1:0] ARSIZE_S0,
	output [1:0] ARBURST_S0,
	output ARVALID_S0,
	input ARREADY_S0,
	//READ DATA0	=ID +`MetaData +`HandShake +RESP
	input [`AXI_IDS_BITS-1:0] RID_S0,
	input [`AXI_DATA_BITS-1:0] RDATA_S0,
	input [1:0] RRESP_S0,
	input RLAST_S0,
	input RVALID_S0,
	output RREADY_S0,
	//READ ADDRESS1	=ID +`AddrInfo +`HandShak
	output [`AXI_IDS_BITS-1:0] ARID_S1,
	output [`AXI_ADDR_BITS-1:0] ARADDR_S1,
	output [`AXI_LEN_BITS-1:0] ARLEN_S1,
	output [`AXI_SIZE_BITS-1:0] ARSIZE_S1,
	output [1:0] ARBURST_S1, 
	output ARVALID_S1,
	input ARREADY_S1,
	//READ DATA1	=ID +`MetaData +`HandShake +RESP
	input [`AXI_IDS_BITS-1:0] RID_S1,
	input [`AXI_DATA_BITS-1:0] RDATA_S1,
	input [1:0] RRESP_S1,
	input RLAST_S1,
	input RVALID_S1,
	output RREADY_S1
	
);

    //---------- you should put your dumb design here ----------//

//verilog "generate" sucks,
//you cant concate it on variable name
//copy paste =_=
// concate wire to struct or interface
`AddrInfo_prepare(	R,	M0)
`HandShake_prepare(	AR,	M0)
`MetaData_prepare(	R,	M0)
`HandShake_prepare(	R,	M0)
//`AddrInfo_prepare(	W,	M0)
//`HandShake_prepare(	AW,	M0)
//`MetaData_prepare(	W,	M0)
//`HandShake_prepare(	W,	M0)
//`HandShake_prepare(	B,	M0)
	
`AddrInfo_prepare(	R,	M1)
`HandShake_prepare(	AR,	M1)
`MetaData_prepare(	R,	M1)
`HandShake_prepare(	R,	M1)
`AddrInfo_prepare(	W,	M1)
`HandShake_prepare(	AW,	M1)
`MetaData_prepare(	W,	M1)
`HandShake_prepare(	W,	M1)
`HandShake_prepare(	B,	M1)
	
`AddrInfo_prepare(	R,	S0)
`HandShake_prepare(	AR,	S0)
`MetaData_prepare(	R,	S0)
`HandShake_prepare(	R,	S0)
`AddrInfo_prepare(	W,	S0)
`HandShake_prepare(	AW,	S0)
`MetaData_prepare(	W,	S0)
`HandShake_prepare(	W,	S0)
`HandShake_prepare(	B,	S0)
	
`AddrInfo_prepare(	R,	S1)
`HandShake_prepare(	AR,	S1)
`MetaData_prepare(	R,	S1)
`HandShake_prepare(	R,	S1)
`AddrInfo_prepare(	W,	S1)
`HandShake_prepare(	AW,	S1)
`MetaData_prepare(	W,	S1)
`HandShake_prepare(	W,	S1)
`HandShake_prepare(	B,	S1)

// Decoder
Decoder 

endmodule
