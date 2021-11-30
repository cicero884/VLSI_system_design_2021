module Arbiter #(parameter channel=2)(
	input ACLK,input ARESETn,
	input begin_sig[channel-1:0],input end_sig[channel-1:0],
	output logic[channel-1:0] direction
);

// round robin main logic:
// direction = begin_sig & ~(begin_sig - priority_circle)
// concate front to consider search again from begining
wire begin_sig_2;
assign begin_sig_2={begin_sig,begin_sig};
wire direction_2;
assign direction_2=begin_sig_2&~(begin_sig_2-priorty_circle);

// start check from which
reg [channel-1:0]priorty_circle;
reg transmitting;
// end until next clock
reg transmitting_ending;

always_ff @(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) transmitting_ending<=0;
	else transmitting_ending<=(end_sig&direction);
end

always_latch begin
	if(!ARESETn) begin
		priorty_circle={channel-1{1'b0},1'b1};
		transmitting=1'b0;
	end
	else begin
		if(transmitting) begin
			if(transmitting_ending) transmitting=1'b0;
		end
		if(!transmitting) begin
			if(begin_sig) begin
				direction=direction_2[2*channel-1:channel] | direction_2[channel-1:0];
				transmitting=1'b1;
			end
			else direction={channel{1'b0}};
		end
	end
end
/*
Pointer last_direction;
Pointer direction;
assign receive_direction=direction;
always_latch begin
	if(!ARESETn) begin
		direction<=DEFAULT;
		last_direction<=DEFAULT;
	end
	else begin
		case(direction)
			SEL0: begin
				if(hs0_end&ACLK) begin
					if(hs1_begin) direction<=SEL1;
					else if(hs0_begin) direction<=SEL0;
					else direction<=DEFAULT;
					last_direction<=SEL0;
				end
			end
			SEL1: begin
				if(hs1_end&ACLK) begin
					if(hs0_begin) direction<=SEL0;
					else if(hs1_begin) direction<=SEL1;
					else direction<=DEFAULT;
					last_direction<=SEL1;
				end
			end
			default: begin
				case(last_direction)
					SEL0: begin
						if(hs1_begin) direction<=SEL1;
						else if(hs0_begin) direction<=SEL0;
					end
					SEL1: begin
						if(hs0_begin) direction<=SEL0;
						else if(hs1_begin) direction<=SEL1;
					end
					default: begin
						if(hs0_begin) direction<=SEL0;
						else if(hs1_begin) direction<=SEL1;
					end
				endcase
			end
		endcase
	end
end
*/
	/*
always_ff @(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		direction<=DEFAULT;
		last_direction<=DEFAULT;
	end
	else begin
		case(direction)
			SEL0: begin
				if(hs0_end) begin
					if(hs1_begin) direction<=SEL1;
					else if(hs0_begin) direction<=SEL0;
					else direction<=DEFAULT;
					last_direction<=SEL0;
				end
			end
			SEL1: begin
				if(hs1_end) begin
					if(hs0_begin) direction<=SEL0;
					else if(hs1_begin) direction<=SEL1;
					else direction<=DEFAULT;
					last_direction<=SEL1;
				end
			end
			default: begin
				case(last_direction)
					SEL0: begin
						if(hs1_begin) direction<=SEL1;
						else if(hs0_begin) direction<=SEL0;
					end
					SEL1: begin
						if(hs0_begin) direction<=SEL0;
						else if(hs1_begin) direction<=SEL1;
					end
					default: begin
						if(hs0_begin) direction<=SEL0;
						else if(hs1_begin) direction<=SEL1;
					end
				endcase
			end
		endcase
	end
end
*/
endmodule

