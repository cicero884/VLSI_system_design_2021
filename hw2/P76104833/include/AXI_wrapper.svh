`ifndef AXI_WRAPPER_SVH
	`define AXI_WRAPPER_SVH

	typedef enum {
		IDLE,
		TRANSMITTING
	} State;

	typedef enum bit[1:0]{
		OKAY=2'b00,
		EXOKAY=2'b01,
		SLVERR=2'b10,
		DECERR=2'b11
	} Responce;

`endif
