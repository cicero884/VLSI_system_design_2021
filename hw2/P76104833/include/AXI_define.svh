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

	// slave number(you need to add 1 for default slave!)
	`define AXI_SLAVE_CNT 3
	
	// define burst type
	typedef enum bit[1:0] {
		FIXED	=2'b00,
		INCR	=2'b01,
		WRAP	=2'b10,
		Reserved=2'b11
	} BurstType;

`endif
