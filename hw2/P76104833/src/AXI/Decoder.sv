`include "AXI_define.svh"

module Decoder(
	input [`AXI_ADDR_BITS]addr,
	output Pointer send_direction
)
always_comb begin
	case(addr[`AXI_ADDR_BITS-1:`AXI_ADDR_BITS-16])
		16'd0:	send_direction<=SEL1;
		16'd1:	send_direction<=SEL2;
		default:send_direction<=DEFAULT;
	endcase
end

endmodule
