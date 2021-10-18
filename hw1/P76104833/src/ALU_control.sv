`include "ALU_signal_def.sv"
module ALU_control(
	//input
	input [6:0]opcode,input [2:0]funct3,input [6:0]funct7,
	//output 
	output logic [`ALU_SIZE-1:0]alu_ctrl,output logic alu_in2_sel
);
ALU_sig alu_ctrl_s;
assign alu_ctrl=alu_ctrl_s;
always_comb begin
	case(opcode)
		7'b0110011: begin//R-type
			alu_in2_sel = 1'b0;
			case({funct7,funct3})	//{ALU_op,is_signed}
				{7'b0000000,3'b000}: alu_ctrl_s={add_,1'b0};//ADD
				{7'b0100000,3'b000}: alu_ctrl_s={sub_,1'b0};//SUB
				{7'b0000000,3'b001}: alu_ctrl_s={sl_, 1'b0};//SLL
				{7'b0000000,3'b010}: alu_ctrl_s={lt_, 1'b1};//SLT
				{7'b0000000,3'b011}: alu_ctrl_s={lt_, 1'b0};//SLTU
				{7'b0000000,3'b100}: alu_ctrl_s={xor_,1'b0};//XOR
				{7'b0000000,3'b101}: alu_ctrl_s={sr_, 1'b0};//SRL
				{7'b0100000,3'b101}: alu_ctrl_s={sr_, 1'b1};//SRA
				{7'b0000000,3'b110}: alu_ctrl_s={or_, 1'b0};//OR
				{7'b0000000,3'b111}: alu_ctrl_s={and_,1'b0};//AND
				default: alu_ctrl_s={nop_,1'b0};
			endcase
		end
		7'b0010011: begin// I-type(default)
			alu_in2_sel = 1'b1;
			case(funct3)
				3'b000: alu_ctrl_s={add_,1'b0};//ADDI
				3'b010: alu_ctrl_s={lt_, 1'b1};//SLTI
				3'b011: alu_ctrl_s={lt_, 1'b0};//SLTIU
				3'b100: alu_ctrl_s={xor_,1'b0};//XORI
				3'b110: alu_ctrl_s={or_ ,1'b0};//ORI
				3'b111: alu_ctrl_s={and_,1'b0};//ANDI
				3'b001: alu_ctrl_s={sl_, 1'b0};//SLLI
				3'b101: alu_ctrl_s={sr_, funct7[5]};//SRLI SRAI
				default: alu_ctrl_s={nop_,1'b0};
			endcase
		end
		7'b1100111,7'b0000011,7'b0100011: begin// I-type(JALR) I-type(M[]) S-type
			alu_in2_sel = 1'b1;
			alu_ctrl_s={add_,1'b0};
		end
		7'b1100011: begin// B-type
			alu_in2_sel = 1'b0;
			case(funct3)
				3'b000: alu_ctrl_s={eq_,1'b0};//BEQ
				3'b001: alu_ctrl_s={ne_,1'b0};//BNE
				3'b100: alu_ctrl_s={lt_,1'b1};//BLT
				3'b101: alu_ctrl_s={ge_,1'b1};//BGE
				3'b110: alu_ctrl_s={lt_,1'b0};//BLTU
				3'b111: alu_ctrl_s={ge_,1'b0};//BGEU
				default: alu_ctrl_s={nop_,1'b0};
			endcase
		end
		7'b0110111: begin// U-type(LUI)
			alu_in2_sel = 1'b1;
			 alu_ctrl_s={imm_,1'b0};
		end
		default: begin// U-type(AUIPC) J-type(JAL) and others
			alu_in2_sel = 1'bx;
			alu_ctrl_s={nop_,1'b0};
		end
	endcase
end
endmodule
