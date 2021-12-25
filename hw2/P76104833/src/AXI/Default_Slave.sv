`include "AXI_define.svh"

module Default_Slave(
	input ACLK,input ARESETn,
	//READ ADDRESS0	=ID +`AddrInfo +`HandShake
	input [`AXI_IDS_BITS-1:0] ARID_S,
	input [`AXI_ADDR_BITS-1:0] ARADDR_S,
	input [`AXI_LEN_BITS-1:0] ARLEN_S,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_S,
	input [1:0] ARBURST_S,
	input ARVALID_S,
	output logic ARREADY_S,
	//READ DATA0	=ID +`DataInfo +`HandShake +RESP
	output logic [`AXI_IDS_BITS-1:0] RID_S,
	output logic [`AXI_DATA_BITS-1:0] RDATA_S,
	output logic [1:0] RRESP_S,
	output logic RLAST_S,
	output logic RVALID_S,
	input RREADY_S,

	//WRITE ADDRESS=ID +`AddrInfo +`HandShake
	input [`AXI_IDS_BITS-1:0] AWID_S,
	input [`AXI_ADDR_BITS-1:0] AWADDR_S,
	input [`AXI_LEN_BITS-1:0] AWLEN_S,
	input [`AXI_SIZE_BITS-1:0] AWSIZE_S,
	input [1:0] AWBURST_S,
	input AWVALID_S,
	output logic AWREADY_S,
	//WRITE DATA0	=   +`DataInfo +`HandShake +STRB
	input [`AXI_DATA_BITS-1:0] WDATA_S,
	input [`AXI_STRB_BITS-1:0] WSTRB_S,
	input WLAST_S,
	input WVALID_S,
	output logic WREADY_S,
	//WRITE RESPONSE0=ID +RESP +`Handshake
	output logic [`AXI_IDS_BITS-1:0] BID_S,
	output logic [1:0] BRESP_S,
	output logic BVALID_S,
	input BREADY_S
);
// wires for SRAM
wire [13:0]A;
wire [31:0]DI;
wire [31:0]DO;
logic [3:0]WEB;
wire CS;
wire OE;

// Read handler
State read_state;
State write_state;

logic [`AXI_ADDR_BITS-1:0] ARADDR;
logic [`AXI_LEN_BITS-1:0] ARLEN;
logic [`AXI_SIZE_BITS-1:0] ARSIZE;
logic [1:0] ARBURST;

Responce resp;
assign resp=DECERR;
assign RRESP_S=resp;
assign RDATA_S=DO;

always_ff @(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		read_state<=IDLE;
		ARREADY_S<=1'b1;// default high(view spec)
		RVALID_S<=1'b0;
		RLAST_S<=1'b0;
	end
	else begin
		case(read_state)
			IDLE:begin
				// set AR
				if(ARVALID_S) begin
					read_state<=TRANSMITTING;
					RID_S<=ARID_S;
					`GET_ADDR(R)
					ARREADY_S<=1'b0;
				end
				else ARREADY_S<=1'b1;// default high(view spec)
				// clean R
				RLAST_S<=1'b0;
				RVALID_S<=1'b0;
			end
			TRANSMITTING: begin
				// set R
				// assume INCR
				if(write_state==TRANSMITTING) RVALID_S<=1'b0;
				else begin
					RVALID_S<=1'b1;
					if(RREADY_S) begin
						ARLEN<=ARLEN-1;
						ARADDR<=ARADDR+4;
						// R end
						if(ARLEN==0) begin
							RLAST_S<=1'b1;
							read_state<=IDLE;
							////if(ARVALID_S) begin
							////	RID_S<=ARID_S;
							////	`GET_ADDR(R)
							////	ARREADY_S<=1'b0;
							////end
							////else begin
							////	ARREADY_S<=1'b1;// default high(view spec)
							////	read_state<=IDLE;
							////end
						end
						////else ARREADY_S<=1'b0;
					end
				end
			end
		endcase
	end
end

// Write handler
//save write AddrInfo in AW_S,cast on aw to use
//AddrInfo aw;
assign BRESP_S=resp;
logic [`AXI_ADDR_BITS-1:0] AWADDR;
logic [`AXI_LEN_BITS-1:0] AWLEN;
logic [`AXI_SIZE_BITS-1:0] AWSIZE;
logic [1:0] AWBURST;

always_ff @(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		write_state<=IDLE;
		AWREADY_S<=1'b1;// default high(view spec)
		WREADY_S<=1'b0;
		WEB<=`AXI_STRB_BITS'd0;
		BVALID_S<=1'b0;
	end
	else begin
		case(write_state)
			IDLE:begin
				BVALID_S<=1'b0;
				WREADY_S<=1'b0;
				if(AWVALID_S&&read_state!=TRANSMITTING) begin
					write_state<=TRANSMITTING;
					BID_S<=AWID_S;
					`GET_ADDR(W)
					AWREADY_S<=1'b0;
				end
				else AWREADY_S<=1'b1;// default high(view spec)
				WEB<=`AXI_STRB_BITS'd0;
			end
			TRANSMITTING:begin
				BVALID_S<=1'b0;
				if(WREADY_S) begin
					WREADY_S<=1'b0;
					WEB<=`AXI_STRB_BITS'd0;
				end
				else if(WVALID_S) begin
					WREADY_S<=1'b1;
					if(AWLEN==0) write_state<=BACK;
					AWLEN<=AWLEN+1;
					AWADDR<=AWADDR+4;
					WEB<=~WSTRB_S;
				end
			end
			BACK:begin
				BVALID_S<=1'b1;
				WEB<=`AXI_STRB_BITS'd0;
				WREADY_S<=1'b0;
				if(BREADY_S) begin
					////if(AWVALID_S&&read_state!=TRANSMITTING) begin
					////	write_state<=TRANSMITTING;
					////	BID_S<=AWID_S;
					////	`GET_ADDR(W)
					////	AWREADY_S<=1'b0;
					////end
					////else begin
					AWREADY_S<=1'b1;// default high(view spec)
					write_state<=IDLE;
					////end
				end
			end
		endcase
	end
end

assign A=(write_state==TRANSMITTING)? AWADDR[15:2]:ARADDR[15:2];
assign DI=WDATA_S;
assign CS=(write_state==TRANSMITTING | read_state==TRANSMITTING);
assign OE=(read_state==TRANSMITTING);

/*
`EMPTY_R()
`EMPTY_W()

// Read handler
State read_state;
//save read AddrInfo in AR_,cast on ar to use
logic [$bits(AddrInfo)-1:0]AR_;
AddrInfo ar;
assign ar=AR_;

DataInfo r;
assign r.data=`AXI_DATA_BITS'dx;
assign R=r;

assign RRESP=DECERR;

always_ff @(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		read_state<=IDLE;
		ARREADY<=1'b1;// default high(view spec)
		RVALID<=1'b0;
		r.last<=1'b0;
	end
	else begin
		case(read_state)
			IDLE:begin
				if(ARVALID) begin
					read_state<=TRANSMITTING;
					RID<=ARID;
					AR_<=AR;
					ARREADY<=1'b0;
				end
				r.last<=1'b0;
			end
			TRANSMITTING: begin
				if(RREADY) begin
					if(RVALID) RVALID<=1'b0;
					else begin
						if(ar.len==0) begin
							r.last<=1'b1;
							read_state<=IDLE;
							ARREADY<=1'b1;// default high(view spec)
						end
						RVALID<=1'b1;
					end
				end
			end
		endcase
	end
end

// Write handler
State write_state;
//save write AddrInfo in AR_,cast on ar to use
logic [$bits(AddrInfo)-1:0]AW_;
AddrInfo aw;
assign aw=AW_;

DataInfo w;
assign w=W;

assign BRESP=DECERR;

always_ff @(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		write_state<=IDLE;
		AWREADY<=1'b1;// default high(view spec)
		WREADY<=1'b0;
		BVALID<=1'b0;
	end
	else begin
		case(write_state)
			IDLE:begin
				BVALID<=1'b0;
				WREADY<=1'b0;
				if(AWVALID) begin
					write_state<=TRANSMITTING;
					BID<=AWID;
					AW_<=AW;
					AWREADY<=1'b0;
				end
			end
			TRANSMITTING:begin
				if(BREADY) begin
					BVALID<=1'b1;// tmp put there to decrease cycle?(test)
					if(WREADY) WREADY<=1'b0;
					else if(WVALID) begin
						WREADY<=1'b1;
						if(w.last) begin
							AWREADY<=1'b1;// default high(view spec)
							write_state<=IDLE;
						end
					end
				end
			end
		endcase
	end
end
*/
endmodule
