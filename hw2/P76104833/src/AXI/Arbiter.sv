module Arbiter #(parameter CHANNEL=2)(
	input ACLK,input ARESETn,
	input [CHANNEL-1:0]begin_sig,input [CHANNEL-1:0]end_sig,
	output logic[CHANNEL-1:0] direction
);


// priority_circle=start check begin_sig from who
reg [CHANNEL-1:0]priority_circle;

// round robin main logic:
// direction = begin_sig & ~(begin_sig - priority_circle)
// concate front to consider search again from begining
logic [CHANNEL*2-1:0] direction_2;

reg transmitting;
// end until next clock
reg transmitting_ending;

always_ff @(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		transmitting_ending<=1'b0;
		priority_circle<={{CHANNEL-1{1'b0}},1'b1};
	end
	else begin
		if(end_sig&direction) begin
			transmitting_ending<=1'b1;
			priority_circle<={direction[CHANNEL-2:0],direction[CHANNEL-1]};
		end
		else transmitting_ending<=1'b0;
	end
end

always_latch begin
	if(!ARESETn) begin
		transmitting=1'b0;
	end
	else begin
		if(transmitting) begin
			if(transmitting_ending) transmitting=1'b0;
		end
		if(!transmitting) begin
			if(begin_sig) begin
				direction_2={begin_sig,begin_sig}&~({begin_sig,begin_sig}-priority_circle);
				direction=direction_2[2*CHANNEL-1:CHANNEL] | direction_2[CHANNEL-1:0];
				transmitting=1'b1;
			end
			else direction={CHANNEL{1'b0}};
		end
	end
end
endmodule
