`include "AXI_define.svh"
`include "AXI_wrapper.svh"
`include "CPU_wrapper.svh"

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
wire [`PC_BITS-1:0]im_addr;
wire [31:0]im_read;
logic sync_i;
// tmp mini cache...
Cache c_i;
assign im_read<=c_i.data;

Burst burst_type;
assign burst_type=INCR;
logic [`AXI_LEN_BITS-1:0]len_cnt_M0_r;

always_ff(posedge clk,posedge rst)begin 
	if(rst) begin
		read_state_M0<=IDLE;
		HSAR_M0.valid<=1'b0;
		HSR_M0.ready<=1'b0;
	end
	else begin
		case(read_state_M0):
			IDLE:begin
				if(c_i.addr!=im_addr) begin
					read_state_M0<=ADDR_HANDSHAKE;
					`SEND_ADDR(R,M0,im_addr)
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
						`SEND_ADDR(R,M0,im_addr)
						HSAR_M0.valid<=1'b1;
						sync_i<=1'b1;
						HSR_M0.ready<=1'b0;
					end
						//TODO
					c_i.data<=R_M0.data;
					c_i.addr<=im_addr+len_cnt_M0_r;
					len_cnt_M0_r<=len_cnt_M0_r+1;
				end
			end
		endcase
	end
end

// Data
wire [`PC_BITS-1:0]dm_addr;
wire [31:0]dm_read;
wire [31:0]dm_write;
logic sync_d_r;
// read handler
State read_state_M1;
// tmp mini cache...
Cache c_d;

Burst burst_type;
assign burst_type=INCR;
logic [`AXI_LEN_BITS-1:0]len_cnt_M1_r;

always_ff(posedge clk,posedge rst)begin 
	if(rst) begin
		read_state_M1<=IDLE;
		HSAR_M1.valid<=1'b0;
		HSR_M1.ready<=1'b0;
	end
	else begin
		case(read_state_M1):
			IDLE:begin
				if(c_d.addr!=dm_addr) begin
					read_state_M1<=ADDR_HANDSHAKE;
					`SEND_ADDR(R,M1,dm_addr)
					HSAR_M1.valid<=1'b1;
					sync_d<=1'b1;
				end
			end
			ADDR_HANDSHAKE:begin
				if(HSAR_M1.ready) begin
					read_state_M1<=TRANSMITTING;
					HSAR_M1.valid<=1'b0;
					HSR_M1.ready<=1'b1;
				end
			end
			TRANSMITTING:begin
				if(HSR.valid&&RRESP_M1==OKAY) begin
					if(R_M1.last) begin
						read_state_M1<=(c.pc==dm_addr)? IDLE:ADDR_HANDSHAKE;
						`SEND_ADDR(R,M1,dm_addr)
						HSAR_M1.valid<=1'b1;
						sync_i<=1'b1;
						HSR_M1.ready<=1'b0;
					end
						//TODO cache
					c_d.data<=R_M1.data;
					c_d.addr<=dm_addr+len_cnt_M1_r;
					len_cnt_M1_r<=len_cnt_M1_r+1;
				end
			end
		endcase
	end
end

// write handler
always_ff(posedge clk,posedge rst) begin
	if(rst) begin
	end
	else begin
		case(data_write_state)
			IDLE:begin
				if(c_d.addr!=dm_addr) begin
					write_state_M1<=ADDR_HANDSHAKE;
					`SEND_ADDR(W,M1,dm_addr)
					HSAW_M1.valid<=1'b1;
					sync_d<=1'b1;
				end
			end
			ADDR_HANDSHAKE:begin
				//TODO
			end
			TRANSMITTING:begin
			end
			BACK:begin
			end
		endcase
	end
end

// connect CPU
CPU cpu(
	//input
	.clk(clk),.rst(rst),.im_data_out(im_read),.dm_data_out(dm_read),sync_i(sync_i),sync_d(sync_d)
	//output
	.im_addr(im_addr),.dm_write_en(WSTRB_M1),.dm_addr(dm_addr),.dm_data_in(dm_write)
);
endmodule
