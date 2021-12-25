module Branch_control(
	//input
	input [6:0]opcode,
	input branch_flag,
	//output 
	output logic [1:0]branch_ctrl
);

always_comb begin
	if(opcode[6:5] == 2'b11) begin
		case (opcode[3:2])
			2'b01: begin/* JALR */
				branch_ctrl=2'b01;
			end
			2'b00: begin/* B type */
				if(branch_flag) branch_ctrl=2'b10;
				else branch_ctrl=2'b00;
			end
			2'b11: begin/* JAL */
				branch_ctrl=2'b10;
			end
			default: branch_ctrl=2'dx;
		endcase
	end
	else branch_ctrl=2'b00;
end
endmodule
