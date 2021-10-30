module Immidiate_generator(
	//input
	input [31:0]instr_imm,
	//output 
	output logic [31:0]immidiate
);
always_comb begin
	case (instr_imm[6:0])//opcode
		7'b0000011,7'b1100111: immidiate = {{21{instr_imm[31]}},instr_imm[30:20]};// I-type(M[],JALR)
		7'b0010011: begin// I-type(others)
			if(instr_imm[14:12]==3'b001 || instr_imm[14:12]==3'b101) immidiate = {{28{instr_imm[24]}},instr_imm[23:20]};//shift
			else immidiate = {{21{instr_imm[31]}},instr_imm[30:20]};//others
		end
		7'b0100011: immidiate = {{21{instr_imm[31]}},instr_imm[30:25],instr_imm[11:7]};//S-type
		7'b1100011: immidiate = {{20{instr_imm[31]}},instr_imm[7],instr_imm[30:25],instr_imm[11:8],1'b0};// B-type
		7'b0010111,7'b0110111:immidiate={instr_imm[31:12],12'd0};// U-type
		7'b1101111:immidiate={{12{instr_imm[31]}},instr_imm[19:12],instr_imm[20],instr_imm[30:21],1'b0};// J-type(JAL)
		default:immidiate=32'dx;
	endcase
end
endmodule
