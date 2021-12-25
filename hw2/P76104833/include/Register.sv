module Register #(parameter SIZE=0)(
	input clk,input rst,input stall
	input [SIZE-1:0]data_in,output logic [SIZE-1:0]data_out
);

always_ff@(posedge clk,posedge rst) begin
	if(rst) data_out<=0;
	else if(!stall) data_out<=data_in;
end
endmodule
