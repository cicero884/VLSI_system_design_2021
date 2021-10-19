module Hazard_control(
	//input
	input clk,input rst,
	input [1:0]branch_ctrl,input mem_r_ex,
	//output 
	output logic pc_stall,output logic [1:0]IF_ID_sf,output logic [1:0]ID_EX_sf,output logic [1:0]EX_MEM_sf,output logic [1:0]MEM_WB_sf
);

logic waiting;
always_comb begin
	pc_stall	=1'b0;
	IF_ID_sf	=2'b0;
	ID_EX_sf	=2'b0;
	EX_MEM_sf	=2'b0;
	MEM_WB_sf	=2'b0;
	if(branch_ctrl!=2'b00) begin
		IF_ID_sf[0]=1'b1;
		ID_EX_sf[0]=1'b1;
		EX_MEM_sf[0]=1'b0;
		MEM_WB_sf[0]=1'b0;
	end
	else if(mem_r_ex && !waiting) begin
		pc_stall	=1'b1;
		IF_ID_sf[1]	=1'b1;
		ID_EX_sf[1]	=1'b1;
		EX_MEM_sf[1]=1'b0;
		MEM_WB_sf[1]=1'b0;
	end
end

always_ff @(posedge clk,posedge rst) begin
	if(rst) waiting<=0;
	else begin
		if(waiting) waiting<=0;
		else if(mem_r_ex) waiting<=1;
	end
end

endmodule
