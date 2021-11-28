`include "AXI_define.svh"
`include "AXI_wrapper.svh"

module Default_Slave(
	input ACLK,input ARESETn,
	//READ ADDRESS
	input [`AXI_IDS_BITS-1:0] ARID,
	input [$bits(AddrInfo)-1:0]AR,
	output logic ARREADY,input ARVALID,

	//READ DATA
	output logic [`AXI_IDS_BITS-1:0] RID,
	output [$bits(DataInfo)-1:0] R,
	output logic [1:0] RRESP,
	input RREADY,output logic RVALID,

	//WRITE ADDRESS
	input [`AXI_IDS_BITS-1:0] AWID,
	input [$bits(AddrInfo)-1:0]AW,
	output logic AWREADY,input AWVALID,
	//WRITE DATA
	input [$bits(DataInfo)-1:0] W,
	input [`AXI_STRB_BITS-1:0] WSTRB,
	output logic WREADY,input WVALID,

	//WRITE RESPONSE
	output logic [`AXI_IDS_BITS-1:0] BID,
	output logic [1:0] BRESP,
	input BREADY,output logic BVALID
);

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
endmodule
