`include "ALU_signal_def.svh"
`define ID_EX_RESET \
	begin \
	pc_out			<=32'd0			; \
	imm_out 		<=32'd0			; \
	opcode_out		<=7'd0			; \
	\
	pc_src_out		<=1'd0			; \
	reg_w_out 		<=1'd0			; \
	wb_sel_out 		<=1'd0 			; \
	rd_src_out 		<=1'd0 			; \
	mem_r_out 		<=1'd0			; \
	mem_w_out 		<=1'd0			; \
	\
	funct3_out 		<=3'd0 			; \
	alu_ctrl_out	<={ALU_op.nop_,1'b0} 	; \
	alu_in2_sel_out<=1'd0			; \
	\
	rs1_data_out	<=32'd0			; \
	rs2_data_out	<=32'd0 		; \
	rs1_addr_out 	<=5'd0 			; \
	rs2_addr_out 	<=5'd0 			; \
	rd_addr_out 	<=5'd0			; \
	end 

module ID_EX_reg(
	//input
	input clk,input rst,input [1:0]sf,
	input [31:0]pc_in,input [31:0]imm_in,input [6:0]opcode_in,
	input pc_src_in,input reg_w_in,input wb_sel_in,input rd_src_in,input mem_r_in,input mem_w_in,
	input [2:0]funct3_in,input [`ALU_SIZE-1:0]alu_ctrl_in,input alu_in2_sel_in,
	input [31:0]rs1_data_in,input [31:0]rs2_data_in,
	input [4:0]rs1_addr_in,input [4:0]rs2_addr_in,input [4:0]rd_addr_in,
	//output
	output logic [31:0]pc_out,output logic [31:0]imm_out,output logic [6:0]opcode_out,
	output logic pc_src_out,output logic reg_w_out,output logic wb_sel_out,output logic rd_src_out,output logic mem_r_out,output logic mem_w_out,
	output logic [2:0]funct3_out,output logic [`ALU_SIZE-1:0]alu_ctrl_out,output logic alu_in2_sel_out,
	output logic [31:0]rs1_data_out,output logic [31:0]rs2_data_out,
	output logic [4:0]rs1_addr_out,output logic [4:0]rs2_addr_out,output logic [4:0]rd_addr_out
);

always_ff @(posedge clk, posedge rst) begin
	if(rst) `ID_EX_RESET
	else begin
		if(sf[0]) `ID_EX_RESET
		else if(!sf[1])  begin
			pc_out			<=pc_in				;
			imm_out 		<=imm_in			;
			opcode_out		<=opcode_in			;

			pc_src_out		<=pc_src_in			;
			reg_w_out 		<=reg_w_in 			;
			wb_sel_out 		<=wb_sel_in 		;
			rd_src_out 		<=rd_src_in 		;
			mem_r_out 		<=mem_r_in 			;
			mem_w_out 		<=mem_w_in 			;

			funct3_out 		<=funct3_in 		;
			alu_ctrl_out	<=alu_ctrl_in 		;
			alu_in2_sel_out	<=alu_in2_sel_in	;

			rs1_data_out	<=rs1_data_in		;
			rs2_data_out	<=rs2_data_in 		;
			rs1_addr_out 	<=rs1_addr_in 		;
			rs2_addr_out 	<=rs2_addr_in 		;
			rd_addr_out 	<=rd_addr_in 		;
		end
	end
end

endmodule
