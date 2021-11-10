`include "AXI_define.svh"

module Decoder(
	input [`AXI_ADDR_BITS]addr,
	output OutPointer out
)
always_comb begin
	case(addr[`AXI_ADDR_BITS-1:`AXI_ADDR_BITS-16])
		16'd0:	out<=OUT1;
		16'd1:	out<=OUT2;
		default:out<=DEFAULT;
	endcase
end

endmodule
