//================================================
// Auther:      Wu zhi-zhong (509)
// Filename:    AXI.sv                            
// Description: Top module of AXI                  
// Version:     1.0 
//================================================
`include "AXI_define.svh"
`include "AXI_package.svh"
`include ""

`include "Arbiter.sv"
`include "Decoder.sv"
`include "Mux_1_to_3.sv"
`include "Mux_3_to_1.sv"
`include "Default_Slave.sv"

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
	//WRITE DATA	=   +`Data +`HandShake
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
	//READ DATA0	=ID +`Data +`HandShake +RESP
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
	//READ DATA1	=ID +`Data +`HandShake +RESP
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
	//WRITE DATA0	=   +`Data +`HandShake +STRB
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
	史卡博羅市集
	//WRITE ADDRESS1=ID +`AddrInfo +`HandShake
	output [`AXI_IDS_BITS-1:0] AWID_S1,
	output [`AXI_ADDR_BITS-1:0] AWADDR_S1,
	output [`AXI_LEN_BITS-1:0] AWLEN_S1,
	output [`AXI_SIZE_BITS-1:0] AWSIZE_S1,
	output [1:0] AWBURST_S1,
	output AWVALID_S1,
	input AWREADY_S1,
	//WRITE DATA1	=   +`Data +`HandShake +STRB
	output [`AXI_DATA_BITS-1:0] WDATA_S1,
	output [`AXI_STRB_BITS-1:0] WSTRB_S1,
	output WLAST_S1,
	output WVALID_S1,
	input WREADY_S1,
	//WRITE RESPONSE1=ID +RESP +`Handshake
	input [`AXI_IDS_BITS-1:0] BID_S1,
	input [1:0] B史卡博羅市集RESP_S1,
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
	//READ DATA0	=ID +`Data +`HandShake +RESP
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
	//READ DATA1	=ID +`Data +`HandShake +RESP
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

`R_in_convert(M0)
//`W_in_convert(M0)
	
`R_in_convert(M1)
`W_in_convert(M1)
	
`R_out_convert(S0)
`W_out_convert(S0)

`R_out_convert(S1)
`W_out_convert(S1)

// Default Master
/*
`CREATE_R(MD)
`CREATE_W(MD)
*/

// Default Slave
`CREATE_R(SD)
`CREATE_W(SD)

// Decoder
// Decoder M0 read
`CREATE_R(C_0_0)
`CREATE_R(C_0_1)
`CREATE_R(C_0_D)
Pointer Pointer_R_M0;
Decoder Decoder_R_M0(AR_M0.addr,Pointer_R_M0);
Mux_1_to_3 #(.SIZE($bits(`R_R_channel(M0))))R_M0_1_to_3(
	`R_R_channel(M0),Pointer_R_M0,
	`R_R_channel(C_0_0),`R_R_channel(C_0_1),`R_R_channel(C_0_D)
)
Mux_3_to_1 #(.SIZE($bits(`R_B_channel(M0))))R_M0_3_to_1(
	`R_B_channel(M0),Pointer_R_M0,
	`R_B_channel(C_0_0),`R_B_channel(C_0_1),`R_B_channel(C_0_D)
)

// Decoder M0 write
/*
`CREATE_W(C_0_0)
`CREATE_W(C_0_1)
`CREATE_W(C_0_D)
Pointer Pointer_W_M0;
Decoder DecoderW_M0(AW_M0.addr,Pointer_W_M0);
Mux_1_to_3 #(.SIZE($bits(`W_R_channel(M0))))R_M0_1_to_3(
	`W_R_channel(M0),Pointer_W_M0,
	`W_R_channel(C_0_0),`W_R_channel(C_0_1),`W_R_channel(C_0_D)
)
Mux_3_to_1 #(.SIZE($bits(`W_B_channel(M0))))R_M0_3_to_1(
	`W_B_channel(M0),Pointer_W_M0,
	`W_B_channel(C_0_0),`W_B_channel(C_0_1),`W_B_channel(C_0_D)
)
*/

// Decoder M1 read
`CREATE_R(C_1_0)
`CREATE_R(C_1_1)
`CREATE_R(C_1_D)
Pointer Pointer_R_M1;
Decoder Decoder_R_M1(AR_M1.addr,Pointer_R_M1);
Mux_1_to_3 #(.SIZE($bits(`R_R_channel(M1))))R_M1_1_to_3(
	`R_R_channel(M1),Pointer_R_M1,
	`R_R_channel(C_1_0),`R_R_channel(C_1_1),`R_R_channel(C_1_D)
)
Mux_3_to_1 #(.SIZE($bits(`R_B_channel(M1))))R_M1_3_to_1(
	`R_B_channel(M1),Pointer_R_M1,
	`R_B_channel(C_1_0),`R_B_channel(C_1_1),`R_B_channel(C_1_D)
)

// Decoder M1 write
`CREATE_W(C_1_0)
`CREATE_W(C_1_1)
`CREATE_W(C_1_D)
Pointer Pointer_W_M1;
Decoder Decoder_W_M1(AW_M1.addr,Pointer_W_M1);
Mux_1_to_3 #(.SIZE($bits(`W_R_channel(M1))))R_M1_1_to_3(
	`W_R_channel(M1),Pointer_W_M1,
	`W_R_channel(C_1_0),`W_R_channel(C_1_1),`W_R_channel(C_1_D)
)
Mux_3_to_1 #(.SIZE($bits(`W_B_channel(M1))))R_M1_3_to_1(
	`W_B_channel(M1),Pointer_W_M1,
	`W_B_channel(C_1_0),`W_B_channel(C_1_1),`W_B_channel(C_1_D)
)

// Decoder default master read
`CREATE_R(C_D_0)
`CREATE_R(C_D_1)
`CREATE_R(C_D_D)
`EMPTY_R(C_D_0)
`EMPTY_R(C_D_1)
`EMPTY_R(C_D_D)
/*
Pointer Pointer_R_MD;
Decoder Decoder_R_MD(AR_MD.addr,Pointer_R_MD);
Mux_1_to_3 #(.SIZE($bits(`R_R_channel(MD))))R_MD_1_to_3(
	`R_R_channel(MD),Pointer_R_MD,
	`R_R_channel(C_D_0),`R_R_channel(C_D_1),`R_R_channel(C_D_D)
)
Mux_3_to_1 #(.SIZE($bits(`R_B_channel(MD))))R_MD_3_to_1(
	`R_B_channel(MD),Pointer_R_MD,
	`R_B_channel(C_D_0),`R_B_channel(C_D_1),`R_B_channel(C_D_D)
)
*/

// Decoder default master write
`CREATE_W(C_D_0)
`CREATE_W(C_D_1)
`CREATE_W(C_D_D)
`EMPTY_W(C_D_0)
`EMPTY_W(C_D_1)
`EMPTY_W(C_D_D)
/*
Pointer Pointer_W_MD;
Decoder Decoder_W_MD(AW_MD.addr,Pointer_W_MD);
Mux_1_to_3 #(.SIZE($bits(`W_R_channel(MD))))R_MD_1_to_3(
	`W_R_channel(MD),Pointer_W_MD,
	`W_R_channel(C_D_0),`W_R_channel(C_D_1),`W_R_channel(C_D_D)
)
Mux_3_to_1 #(.SIZE($bits(`W_B_channel(MD))))R_MD_3_to_1(
	`W_B_channel(MD),Pointer_W_MD,
	`W_B_channel(C_D_0),`W_B_channel(C_D_1),`W_B_channel(C_D_D)
)
*/

// Arbiter
// Arbiter S0 read
Pointer Pointer_R_S0;
Arbiter Arbiter_R_S0(
	ACLK,ARESETn,
	HSAR_C_0_0,HSAR_C_1_0,
	Pointer_R_S0
);
Mux_3_to_1 #(.SIZE($bits(`R_R_channel(S0))))R_S0_3_to_1(
	`R_R_channel(S0),Pointer_R_S0,
	`R_R_channel(C_0_0),`R_R_channel(C_1_0),`R_R_channel(C_D_0)
)
Mux_1_to_3 #(.SIZE($bits(`R_B_channel(S0))))R_S0_1_to_3(
	`R_B_channel(S0),Pointer_R_S0,
	`R_B_channel(C_0_0),`R_B_channel(C_1_0),`R_B_channel(C_D_0)
)

// Arbiter S0 write
assign W_R_channel(S0)=W_R_channel(C_1_0);
assign W_B_channel(C_1_0)=W_R_channel(S0);

// Arbiter S1 read
Pointer Pointer_R_S1;
Arbiter Arbiter_R_S1(
	ACLK,ARESETn,
	HSAR_C_0_1,HSAR_C_1_1,
	Pointer_R_S1
);
Mux_3_to_1 #(.SIZE($bits(`R_R_channel(S1))))R_S1_3_to_1(
	`R_R_channel(S1),Pointer_R_S1,
	`R_R_channel(C_0_1),`R_R_channel(C_1_1),`R_R_channel(C_D_1)
)
Mux_1_to_3 #(.SIZE($bits(`R_B_channel(S1))))R_S1_1_to_3(
	`R_B_channel(S1),Pointer_R_S1,
	`R_B_channel(C_0_1),`R_B_channel(C_1_1),`R_B_channel(C_D_1)
)

// Arbiter S1 write
assign W_R_channel(S1)=W_R_channel(C_1_1);
assign W_B_channel(C_1_1)=W_R_channel(S1);

// Arbiter SD read
Pointer Pointer_R_SD;
Arbiter Arbiter_R_SD(
	ACLK,ARESETn,
	HSAR_C_0_1,HSAR_C_1_1,
	Pointer_R_SD
);
Mux_3_to_1 #(.SIZE($bits(`R_R_channel(SD))))R_SD_3_to_1(
	`R_R_channel(SD),Pointer_R_SD,
	`R_R_channel(C_0_D),`R_R_channel(C_1_D),`R_R_channel(C_D_D)
)
Mux_1_to_3 #(.SIZE($bits(`R_B_channel(SD))))R_SD_1_to_3(
	`R_B_channel(SD),Pointer_R_SD,
	`R_B_channel(C_0_D),`R_B_channel(C_1_D),`R_B_channel(C_D_D)
)

// Arbiter SD write
assign W_R_channel(SD)=W_R_channel(C_1_D);
assign W_B_channel(C_1_D)=W_R_channel(SD);

// Default slave
Default_Slave default slave(
	HSAR_SD,HSAW_SD,HSW_SD,
	HSR_SD,HSB_SD,
	RRESP_SD,BRESP_SD
);
endmodule
