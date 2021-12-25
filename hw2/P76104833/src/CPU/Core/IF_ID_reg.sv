`define IF_ID_RESET \
	begin \
	pc_out		<=32'd0; \
	instr_out	<=32'd0; \
	end

module IF_ID_reg(
	//input
	input clk,input rst,
	input [1:0]sf, input [31:0]pc_in,input [31:0]instr_in,
	//output
	output logic [31:0]pc_out,output logic [31:0] instr_out
);

always_ff @(posedge clk, posedge rst) begin
	if(rst) begin//rst
		`IF_ID_RESET
	end
	else begin
		if(sf[0]) `IF_ID_RESET
		else if(!sf[1])  begin
			pc_out		<=pc_in		;
			instr_out	<=instr_in	;
		end
	end
end
endmodule
