`include "AXI_define.svh"

module Arbiter(
	input ACLK,input ARESETn,
	HandShake.in hs0,
	HandShake.in hs1,
	output logic[`AXI_POINTER_BITS-1:0] receive_direction
);
Pointer last_direction;
Pointer direction;
assign receive_direction=direction;
always_ff @(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		direction<=DEFAULT;
		last_direction<=DEFAULT;
	end
	else begin
		case(direction)
			SEL0: begin
				if(hs0.ready) begin
					if(hs1.valid) direction<=SEL1;
					else if(hs0.valid) direction<=SEL0;
					else direction<=DEFAULT;
					last_direction<=SEL0;
				end
			end
			SEL1: begin
				if(hs1.ready) begin
					if(hs0.valid) direction<=SEL0;
					else if(hs1.valid) direction<=SEL1;
					else direction<=DEFAULT;
					last_direction<=SEL1;
				end
			end
			default: begin
				case(last_direction)
					SEL0: begin
						if(hs1.valid) direction<=SEL1;
						else if(hs0.valid) direction<=SEL0;
					end
					SEL1: begin
						if(hs0.valid) direction<=SEL0;
						else if(hs1.valid) direction<=SEL1;
					end
					default: begin
						if(hs0.valid) direction<=SEL0;
						else if(hs1.valid) direction<=SEL1;
					end
				endcase
			end
		endcase
	end
end
endmodule

