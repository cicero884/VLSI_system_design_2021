`define RANGED_DATA(source,scale,shift) \
	source[{shift,3'd0}+scale-1 -:scale]

module DM_control(
	//input
	input mem_w,input [2:0]funct3,input [31:0]mem_addr,input [31:0]data,input [31:0]rb_data_in,
	//output 
	output logic [31:0]rb_data_out,output logic [3:0]write_bits,output logic [31:0]w_data
);

//read
always_comb begin
	case (funct3)
		3'b000: rb_data_out=$signed(`RANGED_DATA(rb_data_in,8,mem_addr[1:0]));	//LB
		3'b001: rb_data_out=$signed(`RANGED_DATA(rb_data_in,16,mem_addr[0]));	//LH
		3'b010: rb_data_out=rb_data_in;											//LW
		3'b100: rb_data_out=`RANGED_DATA(rb_data_in,8,mem_addr[1:0]);			//LBU
		3'b101: rb_data_out=`RANGED_DATA(rb_data_in,16,mem_addr[0]);			//LHU
		default:rb_data_out=32'd0;
	endcase
end

//write
always_comb begin
	if(mem_w) begin
		case (funct3)
			3'b000: begin //SB
				w_data=data<<{mem_addr[1:0],3'd0};
				write_bits= ~(4'b0001<<mem_addr[1:0]);
			end
			3'b001: begin //SH
				w_data=data<<{mem_addr[1:0],3'd0};
				write_bits=~(4'b0011<<mem_addr[1:0]);
			end
			3'b010: begin //SW
				w_data=data;
				write_bits=4'b0000;
			end
			default: begin
				w_data=32'd0;
				write_bits=4'b1111;
			end
		endcase
	end
	else begin
		w_data=32'd0;
		write_bits=4'b1111;
	end
end
endmodule
