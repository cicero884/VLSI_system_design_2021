`include "AXI_define.svh"

module Arbiter(
	input ACLK,input ARESETn,
	output hs0_receiver,input hs0_sender,
	output hs1_receiver,input hs1_sender,
	output logic[`AXI_POINTER_BITS-1:0] receive_direction
);
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
				if(hs0_receiver) begin
					if(hs1_sender) direction<=SEL1;
					else if(hs0_sender) direction<=SEL0;
					else direction<=DEFAULT;
					last_direction<=SEL0;
				end
			end
			SEL1: begin
				if(hs1_receiver) begin
					if(hs0_sender) direction<=SEL0;
					else if(hs1_sender) direction<=SEL1;
					else direction<=DEFAULT;
					last_direction<=SEL1;
				end
			end
			default: begin
				case(last_direction)
					SEL0: begin
						if(hs1_sender) direction<=SEL1;
						else if(hs0_sender) direction<=SEL0;
					end
					SEL1: begin
						if(hs0_sender) direction<=SEL0;
						else if(hs1_sender) direction<=SEL1;
					end
					default: begin
						if(hs0_sender) direction<=SEL0;
						else if(hs1_sender) direction<=SEL1;
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
				if(hs0_receiver) begin
					if(hs1_sender) direction<=SEL1;
					else if(hs0_sender) direction<=SEL0;
					else direction<=DEFAULT;
					last_direction<=SEL0;
				end
			end
			SEL1: begin
				if(hs1_receiver) begin
					if(hs0_sender) direction<=SEL0;
					else if(hs1_sender) direction<=SEL1;
					else direction<=DEFAULT;
					last_direction<=SEL1;
				end
			end
			default: begin
				case(last_direction)
					SEL0: begin
						if(hs1_sender) direction<=SEL1;
						else if(hs0_sender) direction<=SEL0;
					end
					SEL1: begin
						if(hs0_sender) direction<=SEL0;
						else if(hs1_sender) direction<=SEL1;
					end
					default: begin
						if(hs0_sender) direction<=SEL0;
						else if(hs1_sender) direction<=SEL1;
					end
				endcase
			end
		endcase
	end
end
*/
endmodule

