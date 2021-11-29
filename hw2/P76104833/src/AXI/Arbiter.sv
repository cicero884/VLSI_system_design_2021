`include "AXI_define.svh"
//TODO rewrite round robin
module #(parameter channel=2) Arbiter(
	input ACLK,input ARESETn,
	output hs0_end,input hs0_begin,
	output hs1_end,input hs1_begin,
	output logic[`AXI_POINTER_BITS-1:0] receive_direction
);
Pointer last_direction;
Pointer direction;
assign receive_direction=direction;

reg kept_signal;
always_ff @(posedge ACLK,negedge ARESETn) begin
	
end
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

