`ifndef CPU_WRAPPER_SVH
	`define CPU_WRAPPER_SVH

	`define PC_BITS 14

	typedef struct{
		logic [`PC_BITS-1:0]pc;
		logic [31:0] instruction;
	} Cache;

	`define SEND_ADDR(ROLE,ADDR) \
		ARID_``ROLE``	<=`AXI_ID_BITS'd0; \
		ARADDR_``ROLE``	<={16'd0,ADDR,2'b0}; \
		ARLEN_``ROLE``	<=`AXI_LEN_BITS'd0; \
		ARSIZE_``ROLE``	<=`AXI_SIZE_BITS'd2; \
		ARBURST_``ROLE``<=burst_type; 


`endif
