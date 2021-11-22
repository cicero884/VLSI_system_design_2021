`include "AXI_define.svh"
`include "AXI_wrapper.svh"

module SRAM_wrapper(
	input clk,input rst,
	//READ ADDRESS
	input [`AXI_IDS_BITS-1:0] ARID_S,
	input [`AXI_ADDR_BITS-1:0] ARADDR_S,
	input [`AXI_LEN_BITS-1:0] ARLEN_S,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_S,
	input [1:0] ARBURST_S,
	input ARVALID_S,
	output logic ARREADY_S,
	//READ DATA
	output logic [`AXI_IDS_BITS-1:0] RID_S,
	output logic [`AXI_DATA_BITS-1:0] RDATA_S,
	output logic [1:0] RRESP_S,
	output logic RLAST_S,
	output logic RVALID_S,
	input RREADY_S,

	//WRITE ADDRESS
	input [`AXI_IDS_BITS-1:0] AWID_S,
	input [`AXI_ADDR_BITS-1:0] AWADDR_S,
	input [`AXI_LEN_BITS-1:0] AWLEN_S,
	input [`AXI_SIZE_BITS-1:0] AWSIZE_S,
	input [1:0] AWBURST_S,
	input AWVALID_S,
	output logic AWREADY_S,
	//WRITE DATA
	input [`AXI_DATA_BITS-1:0] WDATA_S,
	input [`AXI_STRB_BITS-1:0] WSTRB_S,
	input WLAST_S,
	input WVALID_S,
	output logic WREADY_S,
	//WRITE RESPONSE
	output logic [`AXI_IDS_BITS-1:0] BID_S,
	output logic [1:0] BRESP_S,
	output logic BVALID_S,
	input BREADY_S,
);
// wires for SRAM
wire [13:0]A;
wire DI[31:0];
wire DO[31:0];
wire WEB[3:0];
wire CS;
wire OE;

// basic convert
`R_in_convert(S)
`W_in_convert(S)

// Read handler
State read_state;
//save read AddrInfo in AR_S(in convert),cast on ar to use
AddrInfo ar;

Responce resp
assign resp=OKAY;
assign RRESP=resp;
logic [`AXI_LEN_BITS-1:0]len_cnt_r;

always_ff(posedge ACLK,posedge rst) begin
	if(!rst) begin
		read_state<=IDLE;
		HSAR_S.ready<=1'b1;// default high(view spec)
		HSR_S.valid<=1'b0;
		r.last<=1'b0;
	end
	else begin
		case(read_state):
			IDLE:begin
				r.last<=1'b0;
				len_cnt_r<=`AXI_LEN_BITS'd0;
				HSR_S.valid<=1'b0;
				if(HSAR.valid) begin
					read_state<=TRANSMITTING;
					RID_S<=ARID_S;
					ar<=AR_S;
					HSAR_S.ready<=1'b0;
				end
				else HSAR_S.ready<=1'b1;// default high(view spec)
			end
			TRANSMITTING: begin
				if(HSR_S.ready) begin
					if(HSR_S.valid) HSR_S.valid<=1'b0;
					else begin
						if(write_state==IDLE) begin
							//assume INCR type
							if(len_cnt_r==ar.len) begin
								r.last<=1'b1;
								read_state<=IDLE;
							end
							r.data<=DO;
							len_cnt_r<=len_cnt_r+1;
							HSR_S.valid<=1'b1;
						end
					end
				end
			end
		endcase
	end
end

// Write handler
State write_state;
//save write AddrInfo in AW_S,cast on ar to use
AddrInfo aw;
assign BRESP=resp;
logic [`AXI_LEN_BITS-1:0]len_cnt_w;

always_ff(posedge ACLK,posedge rst) begin
	if(!rst) begin
		write_state<=IDLE;
		HSAW_S.ready<=1'b1;// default high(view spec)
		HSW_S.ready<=1'b0;
		HSB_S.valid<=1'b0;
	end
	else begin
		case(write_state):
			IDLE:begin
				HSB_S.valid<=1'b0;
				HSW_S.ready<=1'b0;
				if(HSAW_S.valid&&read_state!=TRANSMITTING) begin
					write_state<=TRANSMITTING;
					BID_S<=AWID_S;
					aw<=AW_S;
					HSAW_S.ready<=1'b0;
					len_cnt_w<=`AXI_LEN_BITS'd0;
				end
				else HSAW_S.ready<=1'b1;// default high(view spec)
			end
			TRANSMITTING:begin
				if(HSB_S.ready) begin
					if(HSW_S.ready) begin
						HSW.ready<=1'b0;
						WEB<=`AXI_STRB_BITS'd0;
					end
					else if(HSW_S.valid) begin
						HSW_S.ready<=1'b1;
						if(W_S.last) begin
							HSB_S.valid<=1'b1;
							write_state<=IDLE;
						end
						len_cnt_w<=len_cnt_w+1;
						WEB<=~WSTRB_S;
					end
				end
			end
		endcase
	end
end

assign A=(write_state==TRANSMITTING)? aw.addr[15:2]:ar.addr[15:2];
assign DI=W_S.data;
assign CS=(write_state==TRANSMITTING | read_state==TRANSMITTING);
assign OE=(read_state==TRANSMITTING);

SRAM i_SRAM (
	.A0   (A[0]  ),
	.A1   (A[1]  ),
	.A2   (A[2]  ),
	.A3   (A[3]  ),
	.A4   (A[4]  ),
	.A5   (A[5]  ),
	.A6   (A[6]  ),
	.A7   (A[7]  ),
	.A8   (A[8]  ),
	.A9   (A[9]  ),
	.A10  (A[10] ),
	.A11  (A[11] ),
	.A12  (A[12] ),
	.A13  (A[13] ),
	.DO0  (DO[0] ),
	.DO1  (DO[1] ),
	.DO2  (DO[2] ),
	.DO3  (DO[3] ),
	.DO4  (DO[4] ),
	.DO5  (DO[5] ),
	.DO6  (DO[6] ),
	.DO7  (DO[7] ),
	.DO8  (DO[8] ),
	.DO9  (DO[9] ),
	.DO10 (DO[10]),
	.DO11 (DO[11]),
	.DO12 (DO[12]),
	.DO13 (DO[13]),
	.DO14 (DO[14]),
	.DO15 (DO[15]),
	.DO16 (DO[16]),
	.DO17 (DO[17]),
	.DO18 (DO[18]),
	.DO19 (DO[19]),
	.DO20 (DO[20]),
	.DO21 (DO[21]),
	.DO22 (DO[22]),
	.DO23 (DO[23]),
	.DO24 (DO[24]),
	.DO25 (DO[25]),
	.DO26 (DO[26]),
	.DO27 (DO[27]),
	.DO28 (DO[28]),
	.DO29 (DO[29]),
	.DO30 (DO[30]),
	.DO31 (DO[31]),
	.DI0  (DI[0] ),
	.DI1  (DI[1] ),
	.DI2  (DI[2] ),
	.DI3  (DI[3] ),
	.DI4  (DI[4] ),
	.DI5  (DI[5] ),
	.DI6  (DI[6] ),
	.DI7  (DI[7] ),
	.DI8  (DI[8] ),
	.DI9  (DI[9] ),
	.DI10 (DI[10]),
	.DI11 (DI[11]),
	.DI12 (DI[12]),
	.DI13 (DI[13]),
	.DI14 (DI[14]),
	.DI15 (DI[15]),
	.DI16 (DI[16]),
	.DI17 (DI[17]),
	.DI18 (DI[18]),
	.DI19 (DI[19]),
	.DI20 (DI[20]),
	.DI21 (DI[21]),
	.DI22 (DI[22]),
	.DI23 (DI[23]),
	.DI24 (DI[24]),
	.DI25 (DI[25]),
	.DI26 (DI[26]),
	.DI27 (DI[27]),
	.DI28 (DI[28]),
	.DI29 (DI[29]),
	.DI30 (DI[30]),
	.DI31 (DI[31]),
	.CK   (clk   ),
	.WEB0 (WEB[0]),
	.WEB1 (WEB[1]),
	.WEB2 (WEB[2]),
	.WEB3 (WEB[3]),
	.OE   (OE    ),
	.CS   (CS    )
);

endmodule