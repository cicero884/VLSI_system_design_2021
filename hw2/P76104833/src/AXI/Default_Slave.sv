`include "AXI_define.svh"
`include "AXI_wrapper.svh"

module Default_Slave(
	input ACLK,input ARESETn,
	//READ ADDRESS
	input [`AXI_IDS_BITS-1:0] ARID,
	input [$bits(AddrInfo)-1:0]AR,
	HandShake.in HSAR,

	//READ DATA
	output logic [`AXI_IDS_BITS-1:0] RID,
	output [$bits(DataInfo-1):0] R,
	output logic [1:0] RRESP,
	HandShake.out HSR,

	//WRITE ADDRESS
	input [`AXI_IDS_BITS-1:0] AWID,
	input [$bits(AddrInfo)-1:0]AW,
	HandShake.in HSAW,
	//WRITE DATA
	input [$bits(DataInfo-1):0] W,
	input [`AXI_STRB_BITS-1:0] WSTRB,
	HandShake.in HSW,

	//WRITE RESPONSE
	output logic [`AXI_IDS_BITS-1:0] BID,
	output logic [1:0] BRESP_S,
	HandShake.out HSB,
)

`EMPTY_R()
`EMPTY_W()

// Read handler
State read_state;
//save read AddrInfo in AR_,cast on ar to use
logic [$bits(AddrInfo)-1:0]AR_;
AddrInfo ar;
assign ar=AR_;

DataInfo r;
assign r.data<=`AXI_DATA_BITS'dx;
assign R=r;

assign RRESP=DECERR;

always_ff(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		read_state<=IDLE;
		RID<=`AXI_IDS_BITS'dx;
		AR_<={$bits(AddrInfo){1'bx}};
		HSAR.ready<=1'b1;// default high(view spec)
		HSR.valid<=1'b0;
		r.last<=1'b0;
	end
	else begin
		case(read_state)
			IDLE:begin
				if(HSAR.valid) begin
					read_state<=TRANSMITTING;
					RID<=ARID;
					AR_<=AR;
					HSAR.ready<=1'b0;
				end
				r.last<=1'b0;
			end
			TRANSMITTING: begin
				if(HSR.ready) begin
					if(HSR.valid) HSR.valid<=1'b0;
					else begin
						if(ar.len==0) begin
							r.last<=1'b1;
							read_state<=IDLE;
							HSAR.ready<=1'b1;// default high(view spec)
						end
						HSR.valid<=1'b1;
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

always_ff(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		write_state<=IDLE;
		WID<=`AXI_IDS_BITS'dx;
		AW_<=`AXI_ADDR_BITS'dx;
		HSAW.ready<=1'b1;// default high(view spec)
		HSW.ready<=1'b0;
		HSB.valid<=1'b0;
	end
	else begin
		case(write_state)
			IDLE:begin
				HSB.valid<=1'b0;
				HSW.ready<=1'b0;
				if(HSAW.valid) begin
					write_state<=TRANSMITTING;
					WID<=AWID;
					AW_<=AW;
					HSAW.ready<=1'b0;
				end
			end
			TRANSMITTING:begin
				if(HSB.ready) begin
					HSB.valid<=1'b1;// tmp put there to decrease cycle?(test)
					if(HSW.ready) HSW.ready<=1'b0;
					else if(HSW.valid) begin
						HSW.ready<=1'b1;
						if(w.last) begin
							HSAW.ready<=1'b1;// default high(view spec)
							write_state<=IDLE;
						end
					end
				end
			end
		endcase
	end
end
endmodule
