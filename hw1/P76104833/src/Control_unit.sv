module Control_unit(
	//input
	input [6:0]opcode,
	//output
	output logic pc_src,output logic reg_w,output logic wb_sel,output logic rd_src,output logic mem_r,output logic mem_w
);

always_comb begin
	case (opcode)
		7'b0110011: begin// R-type
			pc_src  = 1'bx;
			reg_w   = 1'b1;
			wb_sel  = 1'b1;
			rd_src  = 1'b0;
			mem_r   = 1'b0;
			mem_w   = 1'b0;
		end
		7'b0010011: begin// I-type(default)
			pc_src  = 1'bx;
			reg_w   = 1'b1;
			wb_sel  = 1'b1;
			rd_src  = 1'b0;
			mem_r   = 1'b0;
			mem_w   = 1'b0;
		end
		7'b1100111: begin// I-type(JALR)
			pc_src  = 1'b0;
			reg_w   = 1'b1;
			wb_sel  = 1'b1;
			rd_src  = 1'b1;
			mem_r   = 1'b0;
			mem_w   = 1'b0;
		end
		7'b0000011: begin// I-type(M[])
			pc_src  = 1'bx;
			reg_w   = 1'b1;
			wb_sel  = 1'b0;
			rd_src  = 1'b0;
			mem_r   = 1'b1;
			mem_w   = 1'b0;
		end
		7'b0100011: begin// S-type
			pc_src  = 1'bx;
			reg_w   = 1'b0;
			wb_sel  = 1'bx;
			rd_src  = 1'bx;
			mem_r   = 1'b0;
			mem_w   = 1'b1;
		end
		7'b1100011: begin// B-type
			pc_src  = 1'b1;
			reg_w   = 1'b0;
			wb_sel  = 1'bx;
			rd_src  = 1'bx;
			mem_r   = 1'b0;
			mem_w   = 1'b0;
		end
		7'b0010111: begin// U-type(AUIPC)
			pc_src  = 1'b1;
			reg_w   = 1'b1;
			wb_sel  = 1'b1;
			rd_src  = 1'b1;
			mem_r   = 1'b0;
			mem_w   = 1'b0;
		end
		7'b0110111: begin// U-type(LUI)
			pc_src  = 1'b1;
			reg_w   = 1'b1;
			wb_sel  = 1'b1;
			rd_src  = 1'b0;
			mem_r   = 1'b0;
			mem_w   = 1'b0;
		end
		7'b1101111: begin// J-type(JAL)
			pc_src  = 1'b0;
			reg_w   = 1'b1;
			wb_sel  = 1'b1;
			rd_src  = 1'b1;
			mem_r   = 1'b0;
			mem_w   = 1'b0;
		end
		default: begin
			pc_src  = 1'bx;
			reg_w   = 1'b0;
			wb_sel  = 1'bx;
			rd_src  = 1'bx;
			mem_r   = 1'b0;
			mem_w   = 1'b0;
		end
	endcase
end
endmodule
