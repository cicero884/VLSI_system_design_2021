module Forward_control(
	//input
	input [4:0]rs1_addr,input [4:0]rs2_addr,
	input reg_w_wb,input [4:0]rd_addr_wb,
	input reg_w_mem,input mem_w_mem,input [4:0]rs2_addr_mem,input [4:0]rd_addr_mem,
	//output 
	output logic [1:0]alu_in1_forward,output logic [1:0]alu_in2_forward,output logic mem_forward
);

//alu_in1
always_comb begin
	if(reg_w_mem && (rd_addr_mem == rs1_addr) && rs1_addr != 32'd0)
		alu_in1_forward = 2'd2;
	else if(reg_w_wb && (rd_addr_wb == rs1_addr) && rs1_addr != 32'd0)
		alu_in1_forward = 2'd1;
	else 
		alu_in1_forward = 2'd0;
end

//alu_in2
always_comb begin
	if(reg_w_mem && (rd_addr_mem == rs2_addr) && rs2_addr != 32'd0)
		alu_in2_forward = 2'd2;
	else if(reg_w_wb && (rd_addr_wb == rs2_addr) && rs2_addr !=32'd0)
		alu_in2_forward = 2'd1;
	else 
		alu_in2_forward = 2'd0;
end

//mem_forward
always_comb begin
	if(reg_w_wb && mem_w_mem && (rs2_addr_mem == rd_addr_wb))
		mem_forward = 1'b1;
	else 
		mem_forward = 1'b0;
end
endmodule
