//================================================
// Auther:      Wu zhi-zhong (509)
// Filename:    AXI.sv                            
// Description: Top module of AXI                  
// Version:     1.0 
//================================================
//TODO 1.use generate to replace similar code
//TODO 2.revert handshake on Arbiter on master
`include "AXI_define.svh"
`include "AXI_package.svh"
//?? lost something need include?

`include "Arbiter.sv"
`include "Decoder.sv"
`include "Mux_2.sv"
`include "Mux_3.sv"
`include "Default_Slave.sv"

module AXI(

	input ACLK,
	input ARESETn,

	//SLAVE INTERFACE FOR MASTERS
	//WRITE ADDRESS	=ID +`AddrInfo +`HandShake
	input [`AXI_IDM_BITS-1:0] AWID_M1,
	input [`AXI_ADDR_BITS-1:0] AWADDR_M1,
	input [`AXI_LEN_BITS-1:0] AWLEN_M1,
	input [`AXI_SIZE_BITS-1:0] AWSIZE_M1,
	input [1:0] AWBURST_M1,
	input AWVALID_M1,
	output AWREADY_M1,
	//WRITE DATA	=   +`DataInfo +STRB +`HandShake
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
	//READ DATA0	=ID +`DataInfo +`HandShake +RESP
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
	//READ DATA1	=ID +`DataInfo +`HandShake +RESP
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
	//WRITE DATA0	=   +`DataInfo +`HandShake +STRB
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
	//WRITE DATA1	=   +`DataInfo +`HandShake +STRB
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
	//READ DATA0	=ID +`DataInfo +`HandShake +RESP
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
	//READ DATA1	=ID +`DataInfo +`HandShake +RESP
	input [`AXI_IDS_BITS-1:0] RID_S1,
	input [`AXI_DATA_BITS-1:0] RDATA_S1,
	input [1:0] RRESP_S1,
	input RLAST_S1,
	input RVALID_S1,
	output RREADY_S1

);

//---------- you should put your dumb design here ----------//
/*
// concate wire to struct
// M0
`R_in_convert(M0)
//`W_in_convert(M0)
`CREATE_W(M0,`AXI_IDM_BITS)
`EMPTY_W(M0)
// M1
`R_in_convert(M1)
`W_in_convert(M1)

// S0
`R_out_convert(S0)
`W_out_convert(S0)
// S1
`R_out_convert(S1)
`W_out_convert(S1)
*/

// Default Master
/*
`CREATE_R(MD,`AXI_IDM_BITS)
`CREATE_W(MD,`AXI_IDM_BITS)
*/

// Default Slave
// TODO SD NAME conflit deal 
`CREATE_R(SD,`AXI_IDS_BITS)
`CREATE_W(SD,`AXI_IDS_BITS)
Default_Slave sd(
	.ACLK(ACLK),.ARESETn(ARESETn),
	//READ ADDRESS
	.ARID(ARID_SD),
	.AR(AR_SD),
	.ARREADY(ARREADY_SD),.ARVALID(ARVALID_SD),

	//READ DATA
	.RID(RID_SD),
	.R(R_SD),
	.RRESP(RRESP_SD),
	.RREADY(RREADY_SD),.RVALID(RVALID_SD),

	//WRITE ADDRESS
	.AWID(AWID_SD),
	.AW(AW_SD),
	.AWREADY(AWREADY_SD),.AWVALID(AWVALID_SD),
	//WRITE DATA
	.W(W_SD),
	.WSTRB(WSTRB_SD),
	.WREADY(WREADY_SD),.WVALID(WVALID_SD),

	//WRITE RESPONSE
	.BID(BID_SD),
	.BRESP(BRESP_SD),
	.BREADY(BREADY_SD),.BVALID(BVALID_SD)
);

// middle wires
`CREATE_R(M0_S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)

`CREATE_R(M1_S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)
`CREATE_W(M1_S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)

`CREATE_R(S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)
`CREATE_W(S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)
// FIXME array may not be able to compress this way
// maybe need to package by my self?
// currect: {a[3], b[3]}
// maybe need '{{a[0],b[0]},{a[1],b[1]}.....}

// middle component(from diagram left to right)
// M0
wire [`AXI_SLAVE_CNT-1:0] direction_AR_M0;
Decoder Decoder_AR_M0(
	.addr(ARADDR_M0),
	.direction(direction_AR_M0)
);
Mux #(.in_size($bits(AR_in(M0))),.out_size($bits(`AR_out(M0))),.channel(`AXI_SLAVE_CNT)) mux_AR_M0(
	.one_in(`AR_in(M0)),			.one_out(`AR_out(M0)),
	.multi_out(`AR_in_mul(M0_S)),	.multi_in(`AR_out_mul(M0_S)),
	.sel(direction_AR_M0)
);

wire [`AXI_SLAVE_CNT-1:0] direction_R_M0;
Arbiter #(.channel(`AXI_SLAVE_CNT)) Arbiter_R_M0(
	.ACLK(ACLK),.ARESETn(ARESETn),
	.begin_sig(ARVALID_M0_S),.end_sig(ARREADY_M0_S),
	.direction(direction_R_M0)
);
Mux #(.in_size($bits(R_in(M0))),.out_size($bits(`R_out(M0))),.channel(`AXI_SLAVE_CNT)) mux_R_M0(
	.one_in(`R_out(M0)),			.one_out(`R_in(M0)),
	.multi_out(`R_out_mul(M0_S)),	.multi_in(`R_in_mul(M0_S)),
	.sel(direction_R_M0)
);
// M1
wire [`AXI_SLAVE_CNT-1:0] direction_AR_M1;
Decoder Decoder_AR_M1(
	.addr(ARADDR_M1),
	.direction(direction_AR_M1)
);
Mux #(.in_size($bits(AR_in(M1))),.out_size($bits(`AR_out(M1))),.channel(`AXI_SLAVE_CNT)) mux_AR_M1(
	.one_in(`AR_in(M1)),			.one_out(`AR_out(M1)),
	.multi_out(`AR_in_mul(M1_S)),	.multi_in(`AR_out_mul(M1_S)),
	.sel(direction_AR_M1)
);

wire [`AXI_SLAVE_CNT-1:0] direction_R_M1;
Arbiter #(.channel(`AXI_SLAVE_CNT)) Arbiter_R_M1(
	.ACLK(ACLK),.ARESETn(ARESETn),
	.begin_sig(ARVALID_M1_S),.end_sig(ARREADY_M1_S),
	.direction(direction_R_M1)
);
Mux #(.in_size($bits(R_in(M1))),.out_size($bits(`R_out(M1))),.channel(`AXI_SLAVE_CNT)) mux_R_M1(
	.one_in(`R_out(M1)),			.one_out(`R_in(M1)),
	.multi_out(`R_out_mul(M1_S)),	.multi_in(`R_in_mul(M1_S)),
	.sel(direction_R_M1)
);

wire [`AXI_SLAVE_CNT-1:0] direction_W_M1;
Decoder Decoder_W_M1(
	.addr(AWADDR_M1),
	.direction(direction_W_M1)
);
Mux #(.in_size($bits(W_in(M1))),.out_size($bits(`W_out(M1))),.channel(`AXI_SLAVE_CNT)) mux_W_M1(
	.one_in(`W_in(M1)),				.one_out(`W_out(M1)),
	.multi_out(`W_in_mul(M1_S)),	.multi_in(`W_out_mul(M1_S)),
	.sel(direction_W_M1)
);

wire [`AXI_SLAVE_CNT-1:0] direction_B_M1;
Arbiter #(.channel(`AXI_SLAVE_CNT)) Arbiter_B_M1(
	.ACLK(ACLK),.ARESETn(ARESETn),
	.begin_sig(BVALID_M1_S),.end_sig(BVALID_M1_S),
	.direction(direction_B_M1)
);
Mux #(.in_size($bits(B_out(M1))),.(out_size($bits(M1))),.channel(`AXI_SLAVE_CNT)) mux_B_M1(
	.one_in(`B_out(M1)),			.one_out(`B_in(M1)),
	multi_out(`B_out_mul(M1_S)),	.multi_in(`B_in_mul(M1_S)),
	.direction(direction_B_M1)
);

// SLAVE
genvar i;

Pointer Pointer_AR_S0;
Arbiter Arbiter_AR_S0(
	.ACLK(ACLK),.ARESETn(ARESETn),
	.hs0_end(ARREADY_0_0),.hs0_begin(ARVALID_0_0),
	.hs1_end(ARREADY_1_0),.hs1_begin(ARREADY_1_0),
	.receive_direction({Pointer_AR_S0})
);
Mux_2 #(.in_size($bits(`AR_out(S0))),.out_size($bits(`AR_in(0_0)))) mux_AR_S0(
	.pointer(Pointer_AR_S0),
	.in_in(`AR_out(S0)),.in_out({ARID_S0[`AXI_IDM_BITS-1:0],AR_S0,ARVALID_S0}),
	.out0_out(`AR_out(0_0)),.out0_in(`AR_in(0_0)),
	.out1_out(`AR_out(1_0)),.out1_in(`AR_in(1_0))
);
assign ARID_S0[`AXI_IDS_BITS-1:`AXI_IDM_BITS]=Pointer_AR_S0;

Pointer Pointer_R_S0;
assign Pointer_R_S0=Pointer'(RID_S0[`AXI_IDS_BITS-1:`AXI_POINTER_BITS]);
Mux_2 #(.in_size($bits(`R_in(1_0))),.out_size($bits(`R_out(S0)))) mux_R_S0(
	.pointer(Pointer_R_S0),
	.in_in({RID_S0[`AXI_IDM_BITS-1:0],R_S0,RRESP_S0,RVALID_S0}),.in_out(`R_out(S0)),
	.out0_out(`R_in(0_0)),.out0_in(`R_out(0_0)),
	.out1_out(`R_in(1_0)),.out1_in(`R_out(1_0))
);

Pointer Pointer_W_S0;
assign Pointer_W_S0=Pointer'(SEL1);
assign `W_in(S0)={{Pointer_W_S0,AWID_1_0},AW_1_0,W_1_0,WVALID_1_0,W_1_0,WVALID_1_0};
assign `W_out(1_0)=`W_out(S0);

Pointer Pointer_B_S0;
assign Pointer_B_S0=Pointer'(SEL1);
assign `B_in(1_0)={BID_S0[`AXI_IDM_BITS-1:0],BRESP_S0,BVALID_S0};
assign `B_out(S0)=`B_out(1_0);

// S1
Pointer Pointer_AR_S1;
Arbiter Arbiter_AR_S1(
	.ACLK(ACLK),.ARESETn(ARESETn),
	.hs0_end(ARREADY_0_1),.hs0_begin(ARVALID_0_1),
	.hs1_end(ARREADY_1_1),.hs1_begin(ARREADY_1_1),
	.receive_direction({Pointer_AR_S1})
);
Mux_2 #(.in_size($bits(`AR_out(S1))),.out_size($bits(`AR_in(0_1)))) mux_AR_S1(
	.pointer(Pointer_AR_S1),
	.in_in(`AR_out(S1)),.in_out({ARID_S1[`AXI_IDM_BITS-1:0],AR_S1,ARVALID_S1}),
	.out0_out(`AR_out(0_1)),.out0_in(`AR_in(0_1)),
	.out1_out(`AR_out(1_1)),.out1_in(`AR_in(1_1))
);
assign ARID_S1[`AXI_IDS_BITS-1:`AXI_IDM_BITS]=Pointer_AR_S1;

Pointer Pointer_R_S1;
assign Pointer_R_S1=Pointer'(RID_S1[`AXI_IDS_BITS-1:`AXI_POINTER_BITS]);
Mux_2 #(.in_size($bits(`R_in(1_1))),.out_size($bits(`R_out(S1)))) mux_R_S1(
	.pointer(Pointer_R_S1),
	.in_in({RID_S1[`AXI_IDM_BITS-1:0],R_S1,RRESP_S1,RVALID_S1}),.in_out(`R_out(S1)),
	.out0_out(`R_in(0_1)),.out0_in(`R_out(0_1)),
	.out1_out(`R_in(1_1)),.out1_in(`R_out(1_1))
);

Pointer Pointer_W_S1;
assign Pointer_W_S1=Pointer'(SEL1);
assign `W_in(S1)={{Pointer_W_S1,AWID_1_1},AW_1_1,W_1_1,WVALID_1_1,W_1_1,WVALID_1_1};
assign `W_out(1_1)=`W_out(S1);

Pointer Pointer_B_S1;
assign Pointer_B_S1=Pointer'(SEL1);
assign `B_in(1_1)={BID_S1[`AXI_IDM_BITS-1:0],BRESP_S1,BVALID_S1};
assign `B_out(S1)=`B_out(1_1);

// SD
Pointer Pointer_AR_SD;
Arbiter Arbiter_AR_SD(
	.ACLK(ACLK),.ARESETn(ARESETn),
	.hs0_end(ARREADY_0_d),.hs0_begin(ARVALID_0_d),
	.hs1_end(ARREADY_1_d),.hs1_begin(ARREADY_1_d),
	.receive_direction({Pointer_AR_SD})
);
Mux_2 #(.in_size($bits(`AR_out(SD))),.out_size($bits(`AR_in(0_d)))) mux_AR_SD(
	.pointer(Pointer_AR_SD),
	.in_in(`AR_out(SD)),.in_out({ARID_SD[`AXI_IDM_BITS-1:0],AR_SD,ARVALID_SD}),
	.out0_out(`AR_out(0_d)),.out0_in(`AR_in(0_d)),
	.out1_out(`AR_out(1_d)),.out1_in(`AR_in(1_d))
);
assign ARID_SD[`AXI_IDS_BITS-1:`AXI_IDM_BITS]=Pointer_AR_SD;

Pointer Pointer_R_SD;
assign Pointer_R_SD=Pointer'(RID_SD[`AXI_IDS_BITS-1:`AXI_POINTER_BITS]);
Mux_2 #(.in_size($bits(`R_in(1_d))),.out_size($bits(`R_out(SD)))) mux_R_SD(
	.pointer(Pointer_R_SD),
	.in_in({RID_SD[`AXI_IDM_BITS-1:0],R_SD,RRESP_SD,RVALID_SD}),.in_out(`R_out(SD)),
	.out0_out(`R_in(0_d)),.out0_in(`R_out(0_d)),
	.out1_out(`R_in(1_d)),.out1_in(`R_out(1_d))
);

Pointer Pointer_W_SD;
assign Pointer_W_SD=Pointer'(SEL1);
assign `W_in(SD)={{Pointer_W_SD,AWID_1_d},AW_1_d,W_1_d,WVALID_1_d,W_1_d,WVALID_1_d};
assign `W_out(1_d)=`W_out(SD);

Pointer Pointer_B_SD;
assign Pointer_B_SD=Pointer'(BID_SD[`AXI_IDS_BITS-1:`AXI_IDM_BITS]);
assign `B_in(1_d)={BID_SD[`AXI_IDM_BITS-1:0],BRESP_SD,BVALID_SD};
assign `B_out(SD)=`B_out(1_d);

endmodule
