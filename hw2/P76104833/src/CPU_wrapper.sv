`include "AXI_define.svh"
`include "AXI_wrapper.svh"

`include "CPU.sv"

module CPU_wrapper(
	input clk,input rst,
	//READ ADDRESS0
	output logic [`AXI_ID_BITS-1:0] ARID_M0,
	output logic [`AXI_ADDR_BITS-1:0] ARADDR_M0,
	output logic [`AXI_LEN_BITS-1:0] ARLEN_M0,
	output logic [`AXI_SIZE_BITS-1:0] ARSIZE_M0,
	output logic [1:0] ARBURST_M0,
	output logic ARVALID_M0,
	input ARREADY_M0,
	//READ DATA0
	input [`AXI_ID_BITS-1:0] RID_M0,
	input [`AXI_DATA_BITS-1:0] RDATA_M0,
	input [1:0] RRESP_M0,
	input RLAST_M0,
	input RVALID_M0,
	output logic RREADY_M0,

	//READ ADDRESS1
	output logic [`AXI_ID_BITS-1:0] ARID_M1,
	output logic [`AXI_ADDR_BITS-1:0] ARADDR_M1,
	output logic [`AXI_LEN_BITS-1:0] ARLEN_M1,
	output logic [`AXI_SIZE_BITS-1:0] ARSIZE_M1,
	output logic [1:0] ARBURST_M1,
	output logic ARVALID_M1,
	input ARREADY_M1,
	//READ DATA1
	input [`AXI_ID_BITS-1:0] RID_M1,
	input [`AXI_DATA_BITS-1:0] RDATA_M1,
	input [1:0] RRESP_M1,
	input RLAST_M1,
	input RVALID_M1,
	output logic RREADY_M1,


	//WRITE ADDRESS
	output logic [`AXI_ID_BITS-1:0] AWID_M1,
	output logic [`AXI_ADDR_BITS-1:0] AWADDR_M1,
	output logic [`AXI_LEN_BITS-1:0] AWLEN_M1,
	output logic [`AXI_SIZE_BITS-1:0] AWSIZE_M1,
	output logic [1:0] AWBURST_M1,
	output logic AWVALID_M1,
	input AWREADY_M1,
	//WRITE DATA
	output logic [`AXI_DATA_BITS-1:0] WDATA_M1,
	output logic [`AXI_STRB_BITS-1:0] WSTRB_M1,
	output logic WLAST_M1,
	output logic WVALID_M1,
	input WREADY_M1,
	//WRITE RESPONSE
	input [`AXI_ID_BITS-1:0] BID_M1,
	input [1:0] BRESP_M1,
	input BVALID_M1,
	output logic BREADY_M1
);

`R_out_convert(M0)
//`W_out_convert(M0)
`R_out_convert(M1)
`W_out_convert(M1)

// Instruction
// read handler
State read_state_M0;
logic [`PC_BITS-1:0]im_addr;
logic [31:0]im_read;
logic sync_i;
// tmp mini cache...
Cache c;
Burst burst_type;
assign burst_type=INCR;

always_ff(posedge clk,negedge rst)begin 
	if(rst) begin
	end
	else begin
		case(read_state_M0):
			IDLE:begin
				if(c.pc!=im_addr) begin
					read_state_M0<=ADDR_HANDSHAKE;
					`SEND_ADDR(M0,im_addr)
					HSAR_M0.valid<=1'b1;
					sync_i<=1'b1;
				end
			end
			ADDR_HANDSHAKE:begin
				if(HSAR_M0.ready) begin
					read_state_M0<=TRANSMITTING;
					HSAR_M0.valid<=1'b0;
					HSR_M0.ready<=1'b1;
				end
			end
			TRANSMITTING:begin
				if(HSR.valid&&RRESP_M0==OKAY) begin
					if(R_M0.last) begin
						read_state_M0<=(c.pc==im_addr)? IDLE:ADDR_HANDSHAKE;
						`SEND_ADDR(M0,im_addr)
						HSAR_M0.valid<=1'b1;
						sync_i<=1'b1;
						HSR_M0.ready<=1'b0;
					end
						//TODO
					
				end
			end
		endcase
	end
end

// Data
logic [`PC_BITS-1:0]dm_addr;
logic [31:0]dm_read;
logic [31:0]dm_write;
logic sync_d;
State data_read_state;
State data_write_state;
// read handler
// write handler

// connect CPU
CPU cpu(
	//input
	.clk(clk),.rst(rst),.im_data_out(im_read),.dm_data_out(dm_read),sync_i(sync_i),sync_d(sync_d)
	//output
	.im_addr(im_addr),.dm_write_en(WSTRB_M1),.dm_addr(dm_addr),.dm_data_in(dm_write)
);
endmodule
