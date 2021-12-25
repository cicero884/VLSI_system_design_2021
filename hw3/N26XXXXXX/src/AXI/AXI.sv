//================================================
// Auther:      Chang Wan-Yun (Claire)
// Filename:    AXI.sv
// Description: Top module of AXI
// Version:     1.0 
//================================================
`include "AXI_define.svh"

module AXI(

  input ACLK,
  input ARESETn,
  //MASTER INTERFACE
  // M0
  // WRITE
  input [`AXI_ID_BITS-1:0]          AWID_M1,
  input [`AXI_ADDR_BITS-1:0]        AWADDR_M1,
  input [`AXI_LEN_BITS-1:0]         AWLEN_M1,
  input [`AXI_SIZE_BITS-1:0]        AWSIZE_M1,
  input [1:0]                       AWBURST_M1,
  input                             AWVALID_M1,
  output logic                      AWREADY_M1,
  input [`AXI_DATA_BITS-1:0]        WDATA_M1,
  input [`AXI_STRB_BITS-1:0]        WSTRB_M1,
  input                             WLAST_M1,
  input                             WVALID_M1,
  output logic                      WREADY_M1,
  output logic [`AXI_ID_BITS-1:0]   BID_M1,
  output logic [1:0]                BRESP_M1,
  output logic                      BVALID_M1,
  input                             BREADY_M1,
  // READ
  input [`AXI_ID_BITS-1:0]          ARID_M0,
  input [`AXI_ADDR_BITS-1:0]        ARADDR_M0,
  input [`AXI_LEN_BITS-1:0]         ARLEN_M0,
  input [`AXI_SIZE_BITS-1:0]        ARSIZE_M0,
  input [1:0]                       ARBURST_M0,
  input                             ARVALID_M0,
  output logic                      ARREADY_M0,
  output logic [`AXI_ID_BITS-1:0]   RID_M0,
  output logic [`AXI_DATA_BITS-1:0] RDATA_M0,
  output logic [1:0]                RRESP_M0,
  output logic                      RLAST_M0,
  output logic                      RVALID_M0,
  input                             RREADY_M0,
  // M1
  // READ
  input [`AXI_ID_BITS-1:0]          ARID_M1,
  input [`AXI_ADDR_BITS-1:0]        ARADDR_M1,
  input [`AXI_LEN_BITS-1:0]         ARLEN_M1,
  input [`AXI_SIZE_BITS-1:0]        ARSIZE_M1,
  input [1:0]                       ARBURST_M1,
  input                             ARVALID_M1,
  output logic                      ARREADY_M1,
  output logic [`AXI_ID_BITS-1:0]   RID_M1,
  output logic [`AXI_DATA_BITS-1:0] RDATA_M1,
  output logic [1:0]                RRESP_M1,
  output logic                      RLAST_M1,
  output logic                      RVALID_M1,
  input                             RREADY_M1,
  //SLAVE INTERFACE
  // S0
  // READ
  output logic [`AXI_IDS_BITS-1:0]  ARID_S0,
  output [`AXI_ADDR_BITS-1:0]       ARADDR_S0,
  output [`AXI_LEN_BITS-1:0]        ARLEN_S0,
  output [`AXI_SIZE_BITS-1:0]       ARSIZE_S0,
  output [1:0]                      ARBURST_S0,
  output logic                      ARVALID_S0,
  input                             ARREADY_S0,
  input [`AXI_IDS_BITS-1:0]         RID_S0,
  input [`AXI_DATA_BITS-1:0]        RDATA_S0,
  input [1:0]                       RRESP_S0,
  input                             RLAST_S0,
  input                             RVALID_S0,
  output logic                      RREADY_S0,
  // S1
  // WRITE
  output logic [`AXI_IDS_BITS-1:0]  AWID_S1,
  output [`AXI_ADDR_BITS-1:0]       AWADDR_S1,
  output [`AXI_LEN_BITS-1:0]        AWLEN_S1,
  output [`AXI_SIZE_BITS-1:0]       AWSIZE_S1,
  output [1:0]                      AWBURST_S1,
  output logic                      AWVALID_S1,
  input                             AWREADY_S1,
  output logic [`AXI_DATA_BITS-1:0] WDATA_S1,
  output logic [`AXI_STRB_BITS-1:0] WSTRB_S1,
  output logic                      WLAST_S1,
  output logic                      WVALID_S1,
  input                             WREADY_S1,
  input [`AXI_IDS_BITS-1:0]         BID_S1,
  input [1:0]                       BRESP_S1,
  input                             BVALID_S1,
  output logic                      BREADY_S1,
  // READ
  output logic [`AXI_IDS_BITS-1:0]  ARID_S1,
  output [`AXI_ADDR_BITS-1:0]       ARADDR_S1,
  output [`AXI_LEN_BITS-1:0]        ARLEN_S1,
  output [`AXI_SIZE_BITS-1:0]       ARSIZE_S1,
  output [1:0]                      ARBURST_S1,
  output logic                      ARVALID_S1,
  input                             ARREADY_S1,
  input [`AXI_IDS_BITS-1:0]         RID_S1,
  input [`AXI_DATA_BITS-1:0]        RDATA_S1,
  input [1:0]                       RRESP_S1,
  input                             RLAST_S1,
  input                             RVALID_S1,
  output logic                      RREADY_S1,
  // S2
  // WRITE
  output logic [`AXI_IDS_BITS-1:0]  AWID_S2,
  output [`AXI_ADDR_BITS-1:0]       AWADDR_S2,
  output [`AXI_LEN_BITS-1:0]        AWLEN_S2,
  output [`AXI_SIZE_BITS-1:0]       AWSIZE_S2,
  output [1:0]                      AWBURST_S2,
  output logic                      AWVALID_S2,
  input                             AWREADY_S2,
  output logic [`AXI_DATA_BITS-1:0] WDATA_S2,
  output logic [`AXI_STRB_BITS-1:0] WSTRB_S2,
  output logic                      WLAST_S2,
  output logic                      WVALID_S2,
  input                             WREADY_S2,
  input [`AXI_IDS_BITS-1:0]         BID_S2,
  input [1:0]                       BRESP_S2,
  input                             BVALID_S2,
  output logic                      BREADY_S2,
  // READ
  output logic [`AXI_IDS_BITS-1:0]  ARID_S2,
  output [`AXI_ADDR_BITS-1:0]       ARADDR_S2,
  output [`AXI_LEN_BITS-1:0]        ARLEN_S2,
  output [`AXI_SIZE_BITS-1:0]       ARSIZE_S2,
  output logic [1:0]                ARBURST_S2,
  output logic                      ARVALID_S2,
  input                             ARREADY_S2,
  input [`AXI_IDS_BITS-1:0]         RID_S2,
  input [`AXI_DATA_BITS-1:0]        RDATA_S2,
  input [1:0]                       RRESP_S2,
  input                             RLAST_S2,
  input                             RVALID_S2,
  output logic                      RREADY_S2,
  // S3
  // WRITE
/*  output logic [`AXI_IDS_BITS-1:0]  AWID_S3,
  output [`AXI_ADDR_BITS-1:0]       AWADDR_S3,
  output [`AXI_LEN_BITS-1:0]        AWLEN_S3,
  output [`AXI_SIZE_BITS-1:0]       AWSIZE_S3,
  output [1:0]                      AWBURST_S3,
  output logic                      AWVALID_S3,
  input                             AWREADY_S3,
  output logic [`AXI_DATA_BITS-1:0] WDATA_S3,
  output logic [`AXI_STRB_BITS-1:0] WSTRB_S3,
  output logic                      WLAST_S3,
  output logic                      WVALID_S3,
  input                             WREADY_S3,
  input [`AXI_IDS_BITS-1:0]         BID_S3,
  input [1:0]                       BRESP_S3,
  input                             BVALID_S3,
  output  logic                     BREADY_S3,
  // READ
  output logic [`AXI_IDS_BITS-1:0]  ARID_S3,
  output [`AXI_ADDR_BITS-1:0]       ARADDR_S3,
  output [`AXI_LEN_BITS-1:0]        ARLEN_S3,
  output [`AXI_SIZE_BITS-1:0]       ARSIZE_S3,
  output logic [1:0]                ARBURST_S3,
  output logic                      ARVALID_S3,
  input                             ARREADY_S3,
  input [`AXI_IDS_BITS-1:0]         RID_S3,
  input [`AXI_DATA_BITS-1:0]        RDATA_S3,
  input [1:0]                       RRESP_S3,
  input                             RLAST_S3,
  input                             RVALID_S3,
  output logic                      RREADY_S3,*/
  // S4
  // WRITE
  output logic [`AXI_IDS_BITS-1:0]  AWID_S4,
  output [`AXI_ADDR_BITS-1:0]       AWADDR_S4,
  output [`AXI_LEN_BITS-1:0]        AWLEN_S4,
  output [`AXI_SIZE_BITS-1:0]       AWSIZE_S4,
  output [1:0]                      AWBURST_S4,
  output logic                      AWVALID_S4,
  input                             AWREADY_S4,
  output logic [`AXI_DATA_BITS-1:0] WDATA_S4,
  output logic [`AXI_STRB_BITS-1:0] WSTRB_S4,
  output logic                      WLAST_S4,
  output logic                      WVALID_S4,
  input                             WREADY_S4,
  input [`AXI_IDS_BITS-1:0]         BID_S4,
  input [1:0]                       BRESP_S4,
  input                             BVALID_S4,
  output logic                      BREADY_S4,
  // READ
  output logic [`AXI_IDS_BITS-1:0]  ARID_S4,
  output [`AXI_ADDR_BITS-1:0]       ARADDR_S4,
  output [`AXI_LEN_BITS-1:0]        ARLEN_S4,
  output [`AXI_SIZE_BITS-1:0]       ARSIZE_S4,
  output [1:0]                      ARBURST_S4,
  output logic                      ARVALID_S4,
  input                             ARREADY_S4,
  input [`AXI_IDS_BITS-1:0]         RID_S4,
  input [`AXI_DATA_BITS-1:0]        RDATA_S4,
  input [1:0]                       RRESP_S4,
  input                             RLAST_S4,
  input                             RVALID_S4,
  output logic                      RREADY_S4
);

// ROM   0x0000_0000 ~ 0x0000_1FFF
// IM    0x0001_0000 ~ 0x0001_FFFF
// DM    0x0002_0000 ~ 0x0002_FFFF
// Sctrl 0x1000_0000 ~ 0x1000_03FF
// DRAM  0x2000_0000 ~ 0x201F_FFFF

endmodule
