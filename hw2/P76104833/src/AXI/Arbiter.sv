`include "AXI_define.svh"

module Arbiter(
	input ACLK,input ARESETn,
	HandShake.in hs1,
	HandShake.in hs2,
	output InPointer receive_direction
);
InPointer last_direction;
always_ff(posedge ACLK,negedge ARESETn) begin
	if(!ARESETn) begin
		receive_direction<=DEFAULT;
		last_direction<=DEFAULT;
	end
	else begin
		last_direction<=receive_direction;
		case(receive_direction):
			IN1: if(hs1.ready) receive_direction<=DEFAULT;
			IN2: if(hs2.ready) receive_direction<=DEFAULT;
			default: begin
				case(last_direction):
					IN1: begin
						if(hs2.valid) receive_direction<=IN2;
						if(hs1.valid) receive_direction<=IN1;
					end
					IN2: begin
						if(hs1.valid) receive_direction<=IN1;
						if(hs2.valid) receive_direction<=IN2;
					end
					default: begin
						if(hs1.valid) receive_direction<=IN1;
						if(hs2.valid) receive_direction<=IN2;
					end
				endcase
			end
		endcase
	end
end
//always_comb begin
//	case(receive_direction):
//		IN1:begin
//			IDOut=ID1;
//			dataOut=data1;
//			respOut=resp1;
//			hsOut=hs1
//		end
//		IN2:begin
//			IDOut=ID2;
//			dataOut=data2;
//			respOut=resp2;
//			hsOut=hs2
//		end
//		default:begin
//			IDOut=IDD;
//			dataOut=dataD;
//			respOut=respD;
//			hsOut=hsD
//		end
//	endcase
//end
endmodule

