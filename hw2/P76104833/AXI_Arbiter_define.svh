`ifndef AXI_ARBITER_SVH
	`define AXI_ARBITER_SVH
	// assume every input and output is ID+data+RESP+handshake in AW,AR,W,R,B
	// only different in data(AddrInfo/MetaData)
	// D=default
	typedef enumi bit[1:0] {IN1,IN2,DEFAULT} Direction;

	`define ARBITER(TYPE,ROLE,DATA) \
		module Arbiter``TYPE``_``INDEX``( \
			input ACLK,input ARESETn, \
			input [`AXI_IDIDS_BITS]ID1, DATA.in data1, input resp1, HandShake.in hs1, \
			input [`AXI_IDIDS_BITS]ID2, DATA.in data2, input resp2, HandShake.in hs2, \
			input [`AXI_IDIDS_BITS]IDD, DATA.in dataD, input respD, HandShake.in hsD, \
			output [`AXI_IDIDS_BITS]IDOut, DATA.out dataOut, output respOut, HandShake.out hsOut \
		); \
		Direction receive_direction,last_direction; \
		always_ff(posedge ACLK,negedge ARESETn) begin \
			if(!ARESETn) begin \
				receive_direction<=DEFAULT; \
				last_direction<=DEFAULT; \
			end \
			else begin \
				last_direction<=receive_direction; \
				case(receive_direction): \
					IN1: if(hs1.ready) receive_direction<=DEFAULT; \
					IN2: if(hs2.ready) receive_direction<=DEFAULT; \
					default: begin \
						case(last_direction): \
							IN1: begin \
								if(hs2.valid) receive_direction<=hs2; \
								if(hs1.valid) receive_direction<=hs1; \
							end \
							IN2: begin \
								if(hs1.valid) receive_direction<=hs1; \
								if(hs2.valid) receive_direction<=hs2; \
							end \
							default: begin \
								if(hs1.valid) receive_direction<=hs1; \
								if(hs2.valid) receive_direction<=hs2; \
							end \
						endcase \
					end \
				endcase \
			end \
		end \
		always_comb begin \
			case(receive_direction): \
				IN1:begin \
					IDOut=ID1; \
					dataOut=data1; \
					respOut=resp1; \
					hsOut=hs1 \
				end \
				IN2:begin \
					IDOut=ID2; \
					dataOut=data2; \
					respOut=resp2; \
					hsOut=hs2 \
				end \
				default:begin \
					IDOut=IDD; \
					dataOut=dataD; \
					respOut=respD; \
					hsOut=hsD \
				end \
			endcase \
		end \
		endmodule \

`endif
