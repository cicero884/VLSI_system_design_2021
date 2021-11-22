`include "ALU_signal_def.svh"

`define CALC_S(EXPR) \
	begin \
	if(alu_ctrl_s.is_signed) alu_out=$signed(alu_in1) EXPR $signed(alu_in2); \
	else alu_out=alu_in1 EXPR alu_in2; \
	branch_flag=1'b0; \
	end
`define CALC_U(EXPR) \
	alu_out=alu_in1 EXPR alu_in2;

`define COMP_S(EXPR) \
	if(alu_ctrl_s.is_signed) begin \
		if($signed(alu_in1) EXPR $signed(alu_in2)) begin\
		alu_out=32'd1; \
		branch_flag=1'b1; \
		end \
		else alu_out=32'd0; \
	end \
	else if(alu_in1 EXPR alu_in2) begin \
		alu_out=32'd1; \
		branch_flag=1'b1; \
	end \
	else alu_out=32'd0;

`define COMP_U(EXPR) \
	if(alu_in1 EXPR alu_in2) begin \
		alu_out=32'd1; \
		branch_flag=1'b1; \
	end \
	else alu_out=32'd0;

module ALU(
	//input
	input ALU_sig alu_ctrl,input [31:0]alu_in1,input [31:0]alu_in2,
	//output 
	output logic branch_flag,output logic [31:0]alu_out
);
ALU_sig alu_ctrl_s;
assign alu_ctrl_s=alu_ctrl;

always_comb begin
	branch_flag=1'b0;
	case (alu_ctrl_s.op)
		xor_:	`CALC_U(^)
		add_:	`CALC_U(+)
		sub_:	`CALC_U(-)
		or_:	`CALC_U(|)
		and_:	`CALC_U(&)
		sl_: alu_out=alu_in1 << alu_in2[4:0]; //shift left
		sr_: begin 				//shift right
			if(alu_ctrl_s.is_signed) alu_out=$signed(alu_in1) >>> alu_in2[4:0];
			else alu_out=alu_in1 >> alu_in2[4:0]; 
		end
		eq_:	`COMP_U(==)		//equal
		ne_:	`COMP_U(!=)		//none equal
		lt_:	`COMP_S(<)		//less than
		ge_:	`COMP_S(>=)		//greater equal
		imm_: alu_out=alu_in2;	//only data from imm(rs2)
		default: alu_out=32'dx;	//other or nop_
	endcase
end
endmodule
