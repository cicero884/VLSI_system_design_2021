module Registers(
	//input
	input clk,input rst,
	input [4:0]rs1_addr,input [4:0]rs2_addr,input reg_w,input [31:0]wd,input [4:0]rd_addr,
	//output
	output [31:0]rs1_data,output [31:0]rs2_data
);
logic [31:0] reg_data [0:31];

assign rs1_data[31:0] =(rs1_addr==5'd0)? 32'd0:(rd_addr == rs1_addr && reg_w) ? wd:reg_data[rs1_addr];
assign rs2_data[31:0] =(rs2_addr==5'd0)? 32'd0:(rd_addr == rs2_addr && reg_w) ? wd:reg_data[rs2_addr];

always_ff @(posedge clk,posedge rst) begin
	if(rst) begin
		reg_data<='{default:32'd0};
	end
	else if(reg_w && rd_addr!=5'd0) reg_data[rd_addr] <= wd;
end

endmodule
