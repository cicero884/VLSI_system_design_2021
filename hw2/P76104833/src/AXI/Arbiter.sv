`include "AXI_define.svh"

module Arbiter(
	input ACLK,input ARESETn,
	HandShake.in hs1,
	HandShake.in hs2,
	output Pointer receive_direction
);
Pointer last_direction;
always_ff(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		receive_direction<=DEFAULT;
		last_direction<=DEFAULT;
	end
	else begin
		last_direction<=receive_direction;
		case(receive_direction):
			SEL1: if(hs1.ready) receive_direction<=DEFAULT;
			SEL2: if(hs2.ready) receive_direction<=DEFAULT;
			default: begin
				case(last_direction):
					SEL1: begin
						if(hs2.valid) receive_direction<=SEL2;
						if(hs1.valid) receive_direction<=SEL1;
					end
					SEL2: begin
						if(hs1.valid) receive_direction<=SEL1;
						if(hs2.valid) receive_direction<=SEL2;
					end
					default: begin
						if(hs1.valid) receive_direction<=SEL1;
						if(hs2.valid) receive_direction<=SEL2;
					end
				endcase
			end
		endcase
	end
end
endmodule

