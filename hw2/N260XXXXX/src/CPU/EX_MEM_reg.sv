`define EX_MEM_RESET \
	begin \
	pc_out		<=32'd0; \
	reg_w_out	<=1'b0; \
	wb_sel_out	<=1'b0; \
	rd_src_out	<=1'b0; \
	mem_r_out	<=1'b0; \
	mem_w_out	<=1'b0; \
	\
	funct3_out	<=3'd0; \
	alu_out_out	<=32'd0; \
	rs2_data_out<=32'd0; \
	rs2_addr_out<=5'd0; \
	rd_addr_out	<=5'd0; \
	end 

module EX_MEM_reg(
	//input
	input clk,input rst,input [1:0]sf,
	input [31:0]pc_in,input reg_w_in,input wb_sel_in,input rd_src_in,input mem_r_in,input mem_w_in,
	input [2:0]funct3_in,input [31:0]alu_out_in,input [31:0]rs2_data_in,input [4:0]rs2_addr_in,input [4:0]rd_addr_in,
	//output
	output logic [31:0]pc_out,output logic reg_w_out,output logic wb_sel_out,output logic rd_src_out,output logic mem_r_out,output logic mem_w_out,
	output logic [2:0]funct3_out,output logic [31:0]alu_out_out,output logic [31:0]rs2_data_out,output logic [4:0]rs2_addr_out,output logic [4:0]rd_addr_out
);

always_ff @(posedge clk,posedge rst) begin
	if(rst) `EX_MEM_RESET
	else begin
		if (sf[0]) `EX_MEM_RESET
		else if(!sf[1]) begin
			pc_out		<=pc_in			;
			reg_w_out	<=reg_w_in		;
			wb_sel_out	<=wb_sel_in		;
			rd_src_out	<=rd_src_in		;
			mem_r_out	<=mem_r_in		;
			mem_w_out	<=mem_w_in		;

			funct3_out	<=funct3_in		;
			alu_out_out	<=alu_out_in	;
			rs2_data_out<=rs2_data_in	;
			rs2_addr_out<=rs2_addr_in	;
			rd_addr_out	<=rd_addr_in	;
		end
	end
end
endmodule
