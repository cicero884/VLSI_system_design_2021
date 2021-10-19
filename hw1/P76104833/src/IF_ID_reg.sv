`define IF_ID_RESET \
	pc_out		<=32'd0; \
	instr_out	<=32'd0; \
	instr_stalled<=1'b0; \
	instr_tmp	<=32'd0;

module IF_ID_reg(
	//input
	input clk,input rst,
	input [1:0]sf, input [31:0]pc_in,input [31:0]instr_in,
	//output
	output logic [31:0]pc_out,output logic [31:0] instr_out
);
logic [31:0]pc_tmp;//instr_mem delay
logic [31:0]instr_tmp;//tmp save when stall
logic flush_prev_instr;
logic instr_stalled;

always_ff @(posedge clk, posedge rst) begin
	if(rst) begin//rst
		`IF_ID_RESET
		pc_tmp		<=32'd0;
		flush_prev_instr<=1'b1;
	end
	else begin
		if(sf[1]) begin//stall
			instr_tmp	<=instr_in;
			instr_stalled<=1'b1;
		end
		else if(instr_stalled) begin
			pc_out 		<=pc_tmp;
			pc_tmp 		<=pc_in;
			instr_stalled<=1'b0;
			instr_out 	<=instr_tmp;
		end
		else if(sf[0]) begin
			`IF_ID_RESET
			pc_tmp		<=32'd0;
			flush_prev_instr<=1'b1;
		end
		else if(flush_prev_instr) begin//remove delayed inster(before jump)
			`IF_ID_RESET
			pc_tmp 		<=pc_in;
			flush_prev_instr<=1'b0;
		end

		else begin
			pc_out 		<=pc_tmp;
			pc_tmp 		<=pc_in;
			instr_out 	<=instr_in;
			flush_prev_instr<=1'b0;
		end
	end
end
endmodule
