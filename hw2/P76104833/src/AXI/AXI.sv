//================================================
// Auther:      Wu zhi-zhong (509)
// Filename:    AXI.sv                            
// Description: Top module of AXI                  
// Version:     1.0 
//================================================
`include "AXI_define.svh"
`include "AXI_package.svh"
//?? lost something need include?

`include "Arbiter.sv"
`include "Decoder.sv"
`include "Mux.sv"
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
// Default Master
/*
`CREATE_R(MD,`AXI_IDM_BITS)
`CREATE_W(MD,`AXI_IDM_BITS)
*/

// Default Slave
`CREATE_R(SD,`AXI_IDS_BITS)
`CREATE_W(SD,`AXI_IDS_BITS)

Default_Slave sd(
	.ACLK(ACLK),.ARESETn(ARESETn),
	//READ ADDRESS
	.ARID_S(ARID_SD),
	.ARADDR_S(ARADDR_SD),
	.ARLEN_S(ARLEN_SD),
	.ARSIZE_S(ARSIZE_SD),
	.ARBURST_S(ARBURST_SD),
	.ARVALID_S(ARVALID_SD),
	.ARREADY_S(ARREADY_SD),
	//READ DATA
	.RID_S(RID_SD),
	.RDATA_S(RDATA_SD),
	.RRESP_S(RRESP_SD),
	.RLAST_S(RLAST_SD),
	.RVALID_S(RVALID_SD),
	.RREADY_S(RREADY_SD),

	//WRITE ADDRESS
	.AWID_S(AWID_SD),
	.AWADDR_S(AWADDR_SD),
	.AWLEN_S(AWLEN_SD),
	.AWSIZE_S(AWSIZE_SD),
	.AWBURST_S(AWBURST_SD),
	.AWVALID_S(AWVALID_SD),
	.AWREADY_S(AWREADY_SD),
	//WRITE DATA
	.WDATA_S(WDATA_SD),
	.WSTRB_S(WSTRB_SD),
	.WLAST_S(WLAST_SD),
	.WVALID_S(WVALID_SD),
	.WREADY_S(WREADY_SD),
	//WRITE RESPONSE
	.BID_S(BID_SD),
	.BRESP_S(BRESP_SD),
	.BVALID_S(BVALID_SD),
	.BREADY_S(BREADY_SD)
);

// middle wires
`CREATE_R(M0_S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)
//`CREATE_W(M0_S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)

`CREATE_R(M1_S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)
`CREATE_W(M1_S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)

`CREATE_R(S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)
`CREATE_W(S[`AXI_SLAVE_CNT],`AXI_IDM_BITS)

// middle component(from diagram left to right)
// M0
wire [`AXI_SLAVE_CNT-1:0] direction_AR_M0;
Decoder Decoder_AR_M0(
	.addr(ARADDR_M0),
	.direction(direction_AR_M0)
);
Mux #(.in_size($bits(`AR_in(M0))),.out_size($bits(`AR_out(M0))),.channel(`AXI_SLAVE_CNT)) mux_AR_M0(
	.one_in(`AR_in(M0)),			.one_out(`AR_out(M0)),
	.multi_out(`TO_MULTI_3(AR_in,M0_S)),	.multi_in(`TO_MULTI_3(AR_out,M0_S)),
	.sel(direction_AR_M0)
);

wire [`AXI_SLAVE_CNT-1:0] direction_R_M0;
Arbiter #(.channel(`AXI_SLAVE_CNT)) Arbiter_R_M0(
	.ACLK(ACLK),.ARESETn(ARESETn),
	.begin_sig({<<{RVALID_M0_S}}),.end_sig({<<{RLAST_M0_S}}),
	.direction(direction_R_M0)
);
Mux #(.in_size($bits(`R_out(M0))),.out_size($bits(`R_in(M0))),.channel(`AXI_SLAVE_CNT)) mux_R_M0(
	.one_in(`R_out(M0)),			.one_out(`R_in(M0)),
	.multi_out(`TO_MULTI_3(R_out,M0_S)),	.multi_in(`TO_MULTI_3(R_in,M0_S)),
	.sel(direction_R_M0)
);
// M1
wire [`AXI_SLAVE_CNT-1:0] direction_AR_M1;
Decoder Decoder_AR_M1(
	.addr(ARADDR_M1),
	.direction(direction_AR_M1)
);
Mux #(.in_size($bits(`AR_in(M1))),.out_size($bits(`AR_out(M1))),.channel(`AXI_SLAVE_CNT)) mux_AR_M1(
	.one_in(`AR_in(M1)),			.one_out(`AR_out(M1)),
	.multi_out(`TO_MULTI_3(AR_in,M1_S)),	.multi_in(`TO_MULTI_3(AR_out,M1_S)),
	.sel(direction_AR_M1)
);

wire [`AXI_SLAVE_CNT-1:0] direction_R_M1;
Arbiter #(.channel(`AXI_SLAVE_CNT)) Arbiter_R_M1(
	.ACLK(ACLK),.ARESETn(ARESETn),
	.begin_sig({<<{RVALID_M1_S}}),.end_sig({<<{RLAST_M1_S}}),
	.direction(direction_R_M1)
);
Mux #(.in_size($bits(`R_out(M1))),.out_size($bits(`R_in(M1))),.channel(`AXI_SLAVE_CNT)) mux_R_M1(
	.one_in(`R_out(M1)),			.one_out(`R_in(M1)),
	.multi_out(`TO_MULTI_3(R_out,M1_S)),	.multi_in(`TO_MULTI_3(R_in,M1_S)),
	.sel(direction_R_M1)
);

wire [`AXI_SLAVE_CNT-1:0] direction_W_M1;
Decoder Decoder_W_M1(
	.addr(AWADDR_M1),
	.direction(direction_W_M1)
);
Mux #(.in_size($bits(`W_in(M1))),.out_size($bits(`W_out(M1))),.channel(`AXI_SLAVE_CNT)) mux_W_M1(
	.one_in(`W_in(M1)),				.one_out(`W_out(M1)),
	.multi_out(`TO_MULTI_3(W_in,M1_S)),	.multi_in(`TO_MULTI_3(W_out,M1_S)),
	.sel(direction_W_M1)
);

wire [`AXI_SLAVE_CNT-1:0] direction_B_M1;
Arbiter #(.channel(`AXI_SLAVE_CNT)) Arbiter_B_M1(
	.ACLK(ACLK),.ARESETn(ARESETn),
	.begin_sig({<<{BVALID_M1_S}}),.end_sig({<<{BVALID_M1_S}}),
	.direction(direction_B_M1)
);
Mux #(.in_size($bits(`B_out(M1))),.out_size($bits(`B_in(M1))),.channel(`AXI_SLAVE_CNT)) mux_B_M1(
	.one_in(`B_out(M1)),			.one_out(`B_in(M1)),
	.multi_out(`TO_MULTI_3(B_out,M1_S)),	.multi_in(`TO_MULTI_3(B_in,M1_S)),
	.sel(direction_B_M1)
);

// SLAVE
genvar i;
logic [1:0]direction_AR_S[`AXI_SLAVE_CNT];
logic [1:0]direction_R_S[`AXI_SLAVE_CNT];
logic [1:0]direction_W_S[`AXI_SLAVE_CNT];
logic [1:0]direction_B_S[`AXI_SLAVE_CNT];

// connect SLAVE(with ID)
assign ARID_S0[`AXI_IDS_BITS-1:`AXI_IDM_BITS]={2'd0,direction_AR_S[0]};
assign ARID_S1[`AXI_IDS_BITS-1:`AXI_IDM_BITS]={2'd0,direction_AR_S[1]};
assign ARID_SD[`AXI_IDS_BITS-1:`AXI_IDM_BITS]={2'd0,direction_AR_S[2]};
assign direction_R_S[0]=RID_S0[5:`AXI_IDM_BITS];
assign direction_R_S[1]=RID_S1[5:`AXI_IDM_BITS];
assign direction_R_S[2]=RID_SD[5:`AXI_IDM_BITS];
assign AWID_S0[`AXI_IDS_BITS-1:`AXI_IDM_BITS]={2'd0,direction_W_S[0]};
assign AWID_S1[`AXI_IDS_BITS-1:`AXI_IDM_BITS]={2'd0,direction_W_S[1]};
assign AWID_SD[`AXI_IDS_BITS-1:`AXI_IDM_BITS]={2'd0,direction_W_S[2]};
assign direction_W_S[0]=BID_S0[5:`AXI_IDM_BITS];
assign direction_W_S[1]=BID_S1[5:`AXI_IDM_BITS];
assign direction_W_S[2]=BID_SD[5:`AXI_IDM_BITS];
`CONNECT_R(S0,S[0])
`CONNECT_R(S1,S[1])
`CONNECT_R(SD,S[2])
`CONNECT_W(S0,S[0])
`CONNECT_W(S1,S[1])
`CONNECT_W(SD,S[2])
// slave relate modules
generate
for(i=0;i<`AXI_SLAVE_CNT;i++) begin: slave
	Arbiter Arbiter_AR_S(
		.ACLK(ACLK),.ARESETn(ARESETn),
		.begin_sig({ARVALID_M1_S[i],ARVALID_M0_S[i]}),.end_sig({ARREADY_M1_S[i],ARREADY_M0_S[i]}),
		.direction(direction_AR_S[i])
	);
	Mux #(.in_size($bits(`AR_out(S[i]))),.out_size($bits(`AR_in(S[i])))) mux_AR_S(
		.one_in(`AR_out(S[i])),.one_out(`AR_in(S[i])),
		.multi_out({`AR_out(M1_S[i]),`AR_out(M0_S[i])}),.multi_in({`AR_in(M1_S[i]),`AR_in(M0_S[i])}),
		.sel(direction_AR_S[i])
	);

	Mux #(.in_size($bits(`R_in(S[i]))),.out_size($bits(`R_out(S[i])))) mux_R_S(
		.one_in(`R_in(S[i])),.one_out(`R_out(S[i])),
		.multi_out({`R_in(M1_S[i]),`R_in(M0_S[i])}),.multi_in({`R_out(M1_S[i]),`R_out(M0_S[i])}),
		.sel(direction_R_S[i])
	);

	`CONNECT_W(S[i],M1_S[i])
end
endgenerate
endmodule
