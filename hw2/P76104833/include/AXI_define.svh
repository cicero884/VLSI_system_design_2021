`ifndef AXI_DEFINE_SVH
	`define AXI_DEFINE_SVH

	`define AXI_IDM_BITS 4
	`define AXI_IDS_BITS 8
	`define AXI_ADDR_BITS 32
	`define AXI_LEN_BITS 4
	`define AXI_SIZE_BITS 3
	`define AXI_DATA_BITS 32
	`define AXI_STRB_BITS 4

	`define AXI_POINTER_BITS (`AXI_IDS_BITS-`AXI_IDM_BITS)

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

	// define interface addr
	typedef struct packed{
		BurstType burst;
		logic [`AXI_ADDR_BITS	-1:0] addr;
		logic [`AXI_LEN_BITS	-1:0] len;
		logic [`AXI_SIZE_BITS	-1:0] size;
	} AddrInfo;

	// define interface data
	typedef struct packed{
		logic [`AXI_DATA_BITS	-1:0] data;
		logic last;
	} DataInfo;

	// direction macro
	typedef enum bit[`AXI_POINTER_BITS-1:0]{SEL0,SEL1,DEFAULT} Pointer;

`endif
