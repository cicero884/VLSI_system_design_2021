`ifndef AXI_DEFINE_SVH
	`define AXI_DEFINE_SVH

	`define AXI_IDM_BITS 4
	`define AXI_IDS_BITS 8
	`define AXI_ADDR_BITS 32
	`define AXI_LEN_BITS 4
	`define AXI_SIZE_BITS 3
	`define AXI_DATA_BITS 32
	`define AXI_STRB_BITS 4
	`define AXI_LEN_ONE 4'h0
	`define AXI_SIZE_BYTE 3'b000
	`define AXI_SIZE_HWORD 3'b001
	`define AXI_SIZE_WORD 3'b010
	`define AXI_BURST_INC 2'h1
	`define AXI_STRB_WORD 4'b1111
	`define AXI_STRB_HWORD 4'b0011
	`define AXI_STRB_BYTE 4'b0001
	`define AXI_RESP_OKAY 2'h0
	`define AXI_RESP_SLVERR 2'h2
	`define AXI_RESP_DECERR 2'h3

	// define MASTER ID
	typedef enum bit[`AXI_ID_BITS-1:0] {
		AXI_MASTER0		=`AXI_ID_BITS'd0,
		AXI_MASTER1		=`AXI_ID_BITS'd1,
		AXI_DEFAULT_MASTER 
	} MasterID;

	// define SLAVE ID
	typedef enum bit[`AXI_IDS_BITS-1:0] {
		AXI_SLAVE0		=`AXI_IDS_BITS'd0,
		AXI_SLAVE1		=`AXI_IDS_BITS'd1,
		AXI_SLAVE2		=`AXI_IDS_BITS'd2,
		AXI_DEFAULT_SLAVE	
	} SlaveID;
	// define burst type
	typedef enum bit[1:0] {
		FIXED	=2'b00,
		INCR	=2'b01,
		WRAP	=2'b10,
		Reserved=2'b11
	} BurstType;

	// valid,ready(handshake)
	interface HandShake();
	logic ready;
	logic valid;
	modport out(input  ready,output valid);//sender
	modport in (output ready,input  valid);//receiver
	endinterface
	`define HandShake_prepare(TYPE,ROLE) \
		HandShake HS``TYPE``_``ROLE``(); \
		HS``TYPE``_``ROLE``.ready=``TYPE``READY_``ROLE`` \
		HS``TYPE``_``ROLE``.valid=``TYPE``VALID_``ROLE`` 

	// define interface addr
	typedef struct packed
	{
		BurstType burst;
		logic [`AXI_ADDR_BITS	-1:0] addr;
		logic [`AXI_LEN_BITS	-1:0] len;
		logic [`AXI_SIZE_BITS	-1:0] size;
	} AddrInfo;
	`define AddrInfo_prepare(RW,ROLE) \
		AddrInfo A``RW``_``ROLE``(); \
		A``RW``_``ROLE``.addr	=A``RW``ADDR_``ROLE``; \
		A``RW``_``ROLE``.len	=A``RW``LEN_``ROLE``; \
		A``RW``_``ROLE``.size	=A``RW``SIZE_``ROLE``; \
		A``RW``_``ROLE``.burst	=A``RW``BURST_``ROLE``;

	// define interface data
	typedef struct packed{
		logic [`AXI_DATA_BITS	-1:0] data;
		logic [`AXI_STRB_BITS	-1:0] strb;
		logic last;
	}MetaData;
	`define MetaData_prepare(RW,ROLE) \
		MetaData ``RW``_``ROLE``(); \
		``RW``_``ROLE``.data	=``RW``DATA_``ROLE``; \
		``RW``_``ROLE``.strb	=``RW``STRB_``ROLE``; \
		``RW``_``ROLE``.last	=``RW``LAST_``ROLE``; 


	// direction macro (one-hot)
	typedef enum {OUT1	,OUT2	,DEFAULT} OutPointer;
	typedef enum {IN1	,IN2	,DEFAULT} InPointer;

`endif
