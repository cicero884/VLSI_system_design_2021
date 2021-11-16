`include "AXI_define.svh"

module Arbiter(
	input ACLK,input ARESETn,
	HandShake.in hs1,
	HandShake.in hs2,
	output logic[AXI_POINTER_BITS-1:0] receive_direction
);
Pointer last_direction;
Pointer direction;
assign receive_direction=direction;
always_ff(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		direction<=DEFAULT;
		last_direction<=DEFAULT;
	end
	else begin
		last_direction<=direction;
		case(direction):
			SEL0: if(hs1.ready) direction<=DEFAULT;
			SEL1: if(hs2.ready) direction<=DEFAULT;
			default: begin
				case(last_direction):
					SEL0: begin
						if(hs2.valid) direction<=SEL1;
						if(hs1.valid) direction<=SEL0;
					end
					SEL1: begin
						if(hs1.valid) direction<=SEL0;
						if(hs2.valid) direction<=SEL1;
					end
					default: begin
						if(hs1.valid) direction<=SEL0;
						if(hs2.valid) direction<=SEL1;
					end
				endcase
			end
		endcase
	end
end
endmodule

