`ifndef CPU_WRAPPER_SVH
	`define CPU_WRAPPER_SVH


	typedef struct packed{
		logic [`CPU_ADDR_BITS-1:0] addr;
		logic [31:0] data;
	} Cache;

	`define SEND_ADDR(RW,ROLE,ADDR) \
		A``RW``VALID_``ROLE``<=1'b1; \
		A``RW``ID_``ROLE``<=`AXI_IDM_BITS'd0; \
		A``RW``ADDR_``ROLE``<={ADDR,2'b0}; \
		A``RW``LEN_``ROLE``	<=`AXI_LEN_BITS'd0; \
		A``RW``SIZE_``ROLE``<=`AXI_SIZE_BITS'd2; \
		A``RW``BURST_``ROLE``<=burst_type; 


`endif
