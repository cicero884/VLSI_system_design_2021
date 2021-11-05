`ifndef ALU_SIGNAL_DEF
	`define ALU_SIGNAL_DEF
	`define ALU_SIZE 5
	typedef enum bit[3:0]{
		nop_,	//do nothing
		xor_,
		add_,
		sub_,
		or_,
		and_,
		sl_,	//shift left
		sr_,	//shift right
		eq_,	//equal
		ne_,	//none equal
		lt_,	//less than
		ge_,	//greater equal
		imm_	//only data from imm(rs2)
	} ALU_op;

	typedef struct packed{
		ALU_op op;
		bit is_signed;
	} ALU_sig;
`endif
