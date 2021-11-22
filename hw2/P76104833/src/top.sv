`include "CPU_wrapper.sv"
`include "SRAM_wrapper.sv"
`include "AXI.sv"

module top(
	input clk,
	input rst
);

wire ARESETn,
assign rst<=~ARESETn;

//SLAVE INTERFACE FOR MASTERS
//WRITE ADDRESS	=ID +`AddrInfo +`HandShake
wire [`AXI_IDM_BITS-1:0] AWID_M1;
wire [`AXI_ADDR_BITS-1:0] AWADDR_M1; in interfac
wire [`AXI_LEN_BITS-1:0] AWLEN_M1;
wire [`AXI_SIZE_BITS-1:0] AWSIZE_M1;
wire [1:0] AWBURST_M1;
wire AWVALID_M1;
wire AWREADY_M1;
//WRITE DATA	=   +`DataInfo +STRB +`HandShake
wire [`AXI_DATA_BITS-1:0] WDATA_M1;
wire [`AXI_STRB_BITS-1:0] WSTRB_M1;
wire WLAST_M1;
wire WVALID_M1;
wire WREADY_M1;
//WRITE RESPONSE=ID +RESP +`Handshake
wire [`AXI_IDM_BITS-1:0] BID_M1;
wire [1:0] BRESP_M1;
wire BVALID_M1;
wire BREADY_M1;

//READ ADDRESS0	=ID +`AddrInfo +`HandShake
wire [`AXI_IDM_BITS-1:0] ARID_M0;
wire [`AXI_ADDR_BITS-1:0] ARADDR_M0;
wire [`AXI_LEN_BITS-1:0] ARLEN_M0;
wire [`AXI_SIZE_BITS-1:0] ARSIZE_M0;
wire [1:0] ARBURST_M0;
wire ARVALID_M0;
wire ARREADY_M0;
//READ DATA0	=ID +`DataInfo +`HandShake +RESP
wire [`AXI_IDM_BITS-1:0] RID_M0;
wire [`AXI_DATA_BITS-1:0] RDATA_M0;
wire [1:0] RRESP_M0;
wire RLAST_M0;
wire RVALID_M0;
wire RREADY_M0;
//READ ADDRESS1	=ID +`AddrInfo +`HandShake
wire [`AXI_IDM_BITS-1:0] ARID_M1;
wire [`AXI_ADDR_BITS-1:0] ARADDR_M1;
wire [`AXI_LEN_BITS-1:0] ARLEN_M1;
wire [`AXI_SIZE_BITS-1:0] ARSIZE_M1;
wire [1:0] ARBURST_M1;
wire ARVALID_M1;
wire ARREADY_M1;
//READ DATA1	=ID +`DataInfo +`HandShake +RESP
wire [`AXI_IDM_BITS-1:0] RID_M1;
wire [`AXI_DATA_BITS-1:0] RDATA_M1;
wire [1:0] RRESP_M1;
wire RLAST_M1;
wire RVALID_M1;
wire RREADY_M1;

//MASTER INTERFACE FOR SLAVES
//WRITE ADDRESS0=ID +`AddrInfo +`HandShake
wire [`AXI_IDS_BITS-1:0] AWID_S0;
wire [`AXI_ADDR_BITS-1:0] AWADDR_S0;
wire [`AXI_LEN_BITS-1:0] AWLEN_S0;
wire [`AXI_SIZE_BITS-1:0] AWSIZE_S0;
wire [1:0] AWBURST_S0;
wire AWVALID_S0;
wire AWREADY_S0;
//WRITE DATA0	=   +`DataInfo +`HandShake +STRB
wire [`AXI_DATA_BITS-1:0] WDATA_S0;
wire [`AXI_STRB_BITS-1:0] WSTRB_S0;
wire WLAST_S0;
wire WVALID_S0;
wire WREADY_S0;
//WRITE RESPONSE0=ID +RESP +`Handshake
wire [`AXI_IDS_BITS-1:0] BID_S0;
wire [1:0] BRESP_S0;
wire BVALID_S0;
wire BREADY_S0;
//WRITE ADDRESS1=ID +`AddrInfo +`HandShake
wire [`AXI_IDS_BITS-1:0] AWID_S1;
wire [`AXI_ADDR_BITS-1:0] AWADDR_S1;
wire [`AXI_LEN_BITS-1:0] AWLEN_S1;
wire [`AXI_SIZE_BITS-1:0] AWSIZE_S1;
wire [1:0] AWBURST_S1;
wire AWVALID_S1;
wire AWREADY_S1;
//WRITE DATA1	=   +`DataInfo +`HandShake +STRB
wire [`AXI_DATA_BITS-1:0] WDATA_S1;
wire [`AXI_STRB_BITS-1:0] WSTRB_S1;
wire WLAST_S1;
wire WVALID_S1;
wire WREADY_S1;
//WRITE RESPONSE1=ID +RESP +`Handshake
wire [`AXI_IDS_BITS-1:0] BID_S1;
wire [1:0] BRESP_S1;
wire BVALID_S1;
wire BREADY_S1;

//READ ADDRESS0	=ID +`AddrInfo +`HandShake
wire [`AXI_IDS_BITS-1:0] ARID_S0;
wire [`AXI_ADDR_BITS-1:0] ARADDR_S0;
wire [`AXI_LEN_BITS-1:0] ARLEN_S0;
wire [`AXI_SIZE_BITS-1:0] ARSIZE_S0;
wire [1:0] ARBURST_S0;
wire ARVALID_S0;
wire ARREADY_S0;
//READ DATA0	=ID +`DataInfo +`HandShake +RESP
wire [`AXI_IDS_BITS-1:0] RID_S0;
wire [`AXI_DATA_BITS-1:0] RDATA_S0;
wire [1:0] RRESP_S0;
wire RLAST_S0;
wire RVALID_S0;
wire RREADY_S0;
//READ ADDRESS1	=ID +`AddrInfo +`HandShak
wire [`AXI_IDS_BITS-1:0] ARID_S1;
wire [`AXI_ADDR_BITS-1:0] ARADDR_S1;
wire [`AXI_LEN_BITS-1:0] ARLEN_S1;
wire [`AXI_SIZE_BITS-1:0] ARSIZE_S1;
wire [1:0] ARBURST_S1; 
wire ARVALID_S1;
wire ARREADY_S1;
//READ DATA1	=ID +`DataInfo +`HandShake +RESP
wire [`AXI_IDS_BITS-1:0] RID_S1;
wire [`AXI_DATA_BITS-1:0] RDATA_S1;
wire [1:0] RRESP_S1;
wire RLAST_S1;
wire RVALID_S1;
wire RREADY_S1;

CPU_wrapper cpu_wrapper(
	.clk(clk),
	.rst(rst),
	//READ ADDRESS0
	.ARID_M0(ARID_M0),
	.ARADDR_M0(ARADDR_M0),
	.ARLEN_M0(ARLEN_M0),
	.ARSIZE_M0(ARSIZE_M0),
	.ARBURST_M0(ARBURST_M0),
	.ARVALID_M0(ARVALID_M0),
	.ARREADY_M0(ARREADY_M0),
	//READ DATA0
	.RID_M0(RID_M0),
	.RDATA_M0(RDATA_M0),
	.RRESP_M0(RRESP_M0),
	.RLAST_M0(RLAST_M0),
	.RVALID_M0(RVALID_M0),
	.RREADY_M0(RREADY_M0),

	//READ ADDRESS1
	.ARID_M1(ARID_M1),
	.ARADDR_M1(ARADDR_M1),
	.ARLEN_M1(ARLEN_M1),
	.ARSIZE_M1(ARSIZE_M1),
	.ARBURST_M1(ARBURST_M1),
	.ARVALID_M1(ARVALID_M1),
	.ARREADY_M1(ARREADY_M1),
	//READ DATA1
	.RID_M1(RID_M1),
	.RDATA_M1(RDATA_M1),
	.RRESP_M1(RRESP_M1),
	.RLAST_M1(RLAST_M1),
	.RVALID_M1(RVALID_M1),
	.RREADY_M1(RREADY_M1),


	//WRITE ADDRESS
	.AWID_M1(AWID_M1),
	.AWADDR_M1(AWADDR_M1),
	.AWLEN_M1(AWLEN_M1),
	.AWSIZE_M1(AWSIZE_M1),
	.AWBURST_M1(AWBURST_M1),
	.AWVALID_M1(AWVALID_M1),
	.AWREADY_M1(AWREADY_M1),
	//WRITE DATA
	.WDATA_M1(WDATA_M1),
	.WSTRB_M1(WSTRB_M1),
	.WLAST_M1(WLAST_M1),
	.WVALID_M1(WVALID_M1),
	.WREADY_M1(WREADY_M1),
	//WRITE RESPONSE
	.BID_M1(BID_M1),
	.BRESP_M1(BRESP_M1),
	.BVALID_M1(BVALID_M1),
	.BREADY_M1(BREADY_M1)
)
AXI axi(
	.ACLK(clk),
	.ARESETn(ARESETn),

	//SLAVE INTERFACE FOR MASTERS
	//WRITE ADDRESS	=ID +`AddrInfo +`HandShake
	.AWID_M1(AWID_M1),
	.AWADDR_M1(AWADDR_M1), in interfac
	.AWLEN_M1(AWLEN_M1),
	.AWSIZE_M1(AWSIZE_M1),
	.AWBURST_M1(AWBURST_M1),
	.AWVALID_M1(AWVALID_M1),
	.AWREADY_M1(AWREADY_M1),
	//WRITE DATA	=   +`DataInfo +STRB +`HandShake
	.WDATA_M1(WDATA_M1),
	.WSTRB_M1(WSTRB_M1),
	.WLAST_M1(WLAST_M1),
	.WVALID_M1(WVALID_M1),
	.WREADY_M1(WREADY_M1),
	//WRITE RESPONSE=ID +RESP +`Handshake
	.BID_M1(BID_M1),
	.BRESP_M1(BRESP_M1),
	.BVALID_M1(BVALID_M1),
	.BREADY_M1(BREADY_M1),

	//READ ADDRESS0	=ID +`AddrInfo +`HandShake
	.ARID_M0(ARID_M0),
	.ARADDR_M0(ARADDR_M0),
	.ARLEN_M0(ARLEN_M0),
	.ARSIZE_M0(ARSIZE_M0),
	.ARBURST_M0(ARBURST_M0),
	.ARVALID_M0(ARVALID_M0),
	.ARREADY_M0(ARREADY_M0),
	//READ DATA0	=ID +`DataInfo +`HandShake +RESP
	.RID_M0(RID_M0),
	.RDATA_M0(RDATA_M0),
	.RRESP_M0(RRESP_M0),
	.RLAST_M0(RLAST_M0),
	.RVALID_M0(RVALID_M0),
	.RREADY_M0(RREADY_M0),
	//READ ADDRESS1	=ID +`AddrInfo +`HandShake
	.ARID_M1(ARID_M1),
	.ARADDR_M1(ARADDR_M1),
	.ARLEN_M1(ARLEN_M1),
	.ARSIZE_M1(ARSIZE_M1),
	.ARBURST_M1(ARBURST_M1),
	.ARVALID_M1(ARVALID_M1),
	.ARREADY_M1(ARREADY_M1),
	//READ DATA1	=ID +`DataInfo +`HandShake +RESP
	.RID_M1(RID_M1),
	.RDATA_M1(RDATA_M1),
	.RRESP_M1(RRESP_M1),
	.RLAST_M1(RLAST_M1),
	.RVALID_M1(RVALID_M1),
	.RREADY_M1(RREADY_M1),

	//MASTER INTERFACE FOR SLAVES
	//WRITE ADDRESS0=ID +`AddrInfo +`HandShake
	.AWID_S0(AWID_S0),
	.AWADDR_S0(AWADDR_S0),
	.AWLEN_S0(AWLEN_S0),
	.AWSIZE_S0(AWSIZE_S0),
	.AWBURST_S0(AWBURST_S0),
	.AWVALID_S0(AWVALID_S0),
	.AWREADY_S0(AWREADY_S0),
	//WRITE DATA0	=   +`DataInfo +`HandShake +STRB
	.WDATA_S0(WDATA_S0),
	.WSTRB_S0(WSTRB_S0),
	.WLAST_S0(WLAST_S0),
	.WVALID_S0(WVALID_S0),
	.WREADY_S0(WREADY_S0),
	//WRITE RESPONSE0=ID +RESP +`Handshake
	.BID_S0(BID_S0),
	.BRESP_S0(BRESP_S0),
	.BVALID_S0(BVALID_S0),
	.BREADY_S0(BREADY_S0),
	//WRITE ADDRESS1=ID +`AddrInfo +`HandShake
	.AWID_S1(AWID_S1),
	.AWADDR_S1(AWADDR_S1),
	.AWLEN_S1(AWLEN_S1),
	.AWSIZE_S1(AWSIZE_S1),
	.AWBURST_S1(AWBURST_S1),
	.AWVALID_S1(AWVALID_S1),
	.AWREADY_S1(AWREADY_S1),
	//WRITE DATA1	=   +`DataInfo +`HandShake +STRB
	.WDATA_S1(WDATA_S1),
	.WSTRB_S1(WSTRB_S1),
	.WLAST_S1(WLAST_S1),
	.WVALID_S1(WVALID_S1),
	.WREADY_S1(WREADY_S1),
	//WRITE RESPONSE1=ID +RESP +`Handshake
	.BID_S1(BID_S1),
	.BRESP_S1(BRESP_S1),
	.BVALID_S1(BVALID_S1),
	.BREADY_S1(BREADY_S1),
	
	//READ ADDRESS0	=ID +`AddrInfo +`HandShake
	.ARID_S0(ARID_S0),
	.ARADDR_S0(ARADDR_S0),
	.ARLEN_S0(ARLEN_S0),
	.ARSIZE_S0(ARSIZE_S0),
	.ARBURST_S0(ARBURST_S0),
	.ARVALID_S0(ARVALID_S0),
	.ARREADY_S0(ARREADY_S0),
	//READ DATA0	=ID +`DataInfo +`HandShake +RESP
	.RID_S0(RID_S0),
	.RDATA_S0(RDATA_S0),
	.RRESP_S0(RRESP_S0),
	.RLAST_S0(RLAST_S0),
	.RVALID_S0(RVALID_S0),
	.RREADY_S0(RREADY_S0),
	//READ ADDRESS1	=ID +`AddrInfo +`HandShak
	.ARID_S1(ARID_S1),
	.ARADDR_S1(ARADDR_S1),
	.ARLEN_S1(ARLEN_S1),
	.ARSIZE_S1(ARSIZE_S1),
	.ARBURST_S1(ARBURST_S1), 
	.ARVALID_S1(ARVALID_S1),
	.ARREADY_S1(ARREADY_S1),
	//READ DATA1	=ID +`DataInfo +`HandShake +RESP
	.RID_S1(RID_S1),
	.RDATA_S1(RDATA_S1),
	.RRESP_S1(RRESP_S1),
	.RLAST_S1(RLAST_S1),
	.RVALID_S1(RVALID_S1),
	.RREADY_S1(RREADY_S1)
);


SRAM_wrapper S0(
	.clk(clk),
	.rst(rst),
	//READ ADDRESS
	.ARID_S(ARID_S0),
	.ARADDR_S(ARADDR_S0),
	.ARLEN_S(ARLEN_S0),
	.ARSIZE_S(ARSIZE_S0),
	.ARBURST_S(ARBURST_S0),
	.ARVALID_S(ARVALID_S0),
	.ARREADY_S(ARREADY_S0),
	//READ DATA
	.RID_S(RID_S0),
	.RDATA_S(RDATA_S0),
	.RRESP_S(RRESP_S0),
	.RLAST_S(RLAST_S0),
	.RVALID_S(RVALID_S0),
	.RREADY_S(RREADY_S0),

	//WRITE ADDRESS
	.AWID_S(AWID_S0),
	.AWADDR_S(AWADDR_S0),
	.AWLEN_S(AWLEN_S0),
	.AWSIZE_S(AWSIZE_S0),
	.AWBURST_S(AWBURST_S0),
	.AWVALID_S(AWVALID_S0),
	.AWREADY_S(AWREADY_S0),
	//WRITE DATA
	.WDATA_S(WDATA_S0),
	.WSTRB_S(WSTRB_S0),
	.WLAST_S(WLAST_S0),
	.WVALID_S(WVALID_S0),
	.WREADY_S(WREADY_S0),
	//WRITE RESPONSE
	.BID_S(BID_S0),
	.BRESP_S(BRESP_S0),
	.BVALID_S(BVALID_S0),
	.BREADY_S(BREADY_S0)
);

SRAM_wrapper S1(
	.clk(clk),
	.rst(rst),
	//READ ADDRESS
	.ARID_S(ARID_S1),
	.ARADDR_S(ARADDR_S1),
	.ARLEN_S(ARLEN_S1),
	.ARSIZE_S(ARSIZE_S1),
	.ARBURST_S(ARBURST_S1),
	.ARVALID_S(ARVALID_S1),
	.ARREADY_S(ARREADY_S1),
	//READ DATA
	.RID_S(RID_S1),
	.RDATA_S(RDATA_S1),
	.RRESP_S(RRESP_S1),
	.RLAST_S(RLAST_S1),
	.RVALID_S(RVALID_S1),
	.RREADY_S(RREADY_S1),

	//WRITE ADDRESS
	.AWID_S(AWID_S1),
	.AWADDR_S(AWADDR_S1),
	.AWLEN_S(AWLEN_S1),
	.AWSIZE_S(AWSIZE_S1),
	.AWBURST_S(AWBURST_S1),
	.AWVALID_S(AWVALID_S1),
	.AWREADY_S(AWREADY_S1),
	//WRITE DATA
	.WDATA_S(WDATA_S1),
	.WSTRB_S(WSTRB_S1),
	.WLAST_S(WLAST_S1),
	.WVALID_S(WVALID_S1),
	.WREADY_S(WREADY_S1),
	//WRITE RESPONSE
	.BID_S(BID_S1),
	.BRESP_S(BRESP_S1),
	.BVALID_S(BVALID_S1),
	.BREADY_S(BREADY_S1)
);

endmodule
