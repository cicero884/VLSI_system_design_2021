`define MEM_WB_RESET \
	begin \
		reg_w_out	<=1'b0; \
		wb_sel_out	<=1'b0; \
		rd_data_out	<=32'd0; \
		rb_data_out	<=32'd0; \
		rd_addr_out	<=5'd0; \
	end

module MEM_WB_reg(
	//input
	input clk,input rst,input [1:0]sf,
	input reg_w_in,input wb_sel_in,[31:0]rd_data_in,input [31:0]rb_data_in,input [4:0]rd_addr_in,
	//output
	output logic reg_w_out,output logic wb_sel_out,output logic[31:0]rd_data_out,output logic [31:0]rb_data_out,output logic [4:0]rd_addr_out
);

always_ff @(posedge clk,posedge rst) begin
	if(rst) `MEM_WB_RESET
	else begin
		if(sf[0]) `MEM_WB_RESET
		else if(!sf[1]) begin
			reg_w_out	<=reg_w_in	;
			wb_sel_out	<=wb_sel_in	;
			rd_data_out	<=rd_data_in;
			rb_data_out	<=rb_data_in;
			rd_addr_out	<=rd_addr_in;
		end
	end
end
endmodule
