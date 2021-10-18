`include "Adder.sv"
`include "Mux_2in.sv"
`include "Mux_3in.sv"

`include "IF_ID_reg.sv"
`include "ID_EX_reg.sv"
`include "EX_MEM_reg.sv"
`include "MEM_WB_reg.sv"

`include "Control_unit.sv"
`include "ALU_control.sv"
`include "Branch_control.sv"
`include "Forward_control.sv"
`include "DM_control.sv"
`include "Hazard_control.sv"

`include "PC_reg.sv"
`include "Immidiate_generator.sv"
`include "Register.sv"
`include "ALU.sv"

`define sig_Rs2 24:20
`define sig_Rs1 19:15
`define sig_Funct3 14:12
`define sig_Rd 11:7
`define sig_Opcode 6:0


module CPU(
	//input
	input clk,input rst,input [31:0]im_data_out,input [31:0]dm_data_out,
	//output
	output [13:0]im_addr,output [3:0]dm_write_en,output [13:0]dm_addr,output [31:0]dm_data_in
);

/* hazard control */
//sf= stall & flush
wire [1:0]branch_ctrl;
wire mem_r_ex;

wire pc_stall;
wire [1:0]IF_ID_sf;
wire [1:0]ID_EX_sf;
wire [1:0]EX_MEM_sf;
wire [1:0]MEM_WB_sf;
Hazard_control hazard_control(
	.clk(clk),.rst(rst),
	.branch_ctrl(branch_ctrl),.mem_r_ex(mem_r_ex),
	.pc_stall(pc_stall),.IF_ID_sf(IF_ID_sf),.ID_EX_sf(ID_EX_sf),.EX_MEM_sf(EX_MEM_sf),.MEM_WB_sf(MEM_WB_sf)
);


/* IF */
wire [31:0]pc_now;
wire [31:0]pc_next_if;
Adder pc_adder_if(
	.in1(pc_now),.in2(32'd4),
	.out(pc_next_if)
);

wire [31:0]alu_out;
wire [31:0]pc_branch;
wire [31:0]pc_mux_out_if;
Mux_3in pc_mux(
	.ctrl(branch_ctrl),.in0(pc_next_if),.in1(alu_out),.in2(pc_branch),
	.out(pc_mux_out_if)
);

PC_reg pc_reg(
	.clk(clk),.rst(rst),.stall(pc_stall),.pc_in(pc_mux_out_if),
	.pc_out(pc_now)
);

assign im_addr = pc_now[15:2];
wire [31:0]instr_if = im_data_out;

/* IF_ID */
wire [31:0]instr_id;
wire [31:0]pc_id;
IF_ID_reg if_id(
	.clk(clk),.rst(rst),
	.sf(IF_ID_sf),.pc_in(pc_now),.instr_in(instr_if),
	.pc_out(pc_id),.instr_out(instr_id)
);

/* ID */

wire [31:0]imm;
Immidiate_generator immidiate_generator(
	.instr_imm(instr_id),
	.immidiate(imm)
);

wire pc_src;
wire reg_w;
wire wb_sel;
wire rd_src;
wire disable_stall;
wire mem_r;
wire mem_w;
Control_unit control_unit(
	.opcode(instr_id[`sig_Opcode]),
	.pc_src(pc_src),.reg_w(reg_w),.wb_sel(wb_sel),.rd_src(rd_src),.mem_r(mem_r),.mem_w(mem_w)
);

wire [`ALU_SIZE-1:0]alu_ctrl;
wire alu_in2_sel;
ALU_control alu_control(
	.opcode(instr_id[`sig_Opcode]),.funct3(instr_id[`sig_Funct3]),.funct7(instr_id[31:25]),
	.alu_ctrl(alu_ctrl),.alu_in2_sel(alu_in2_sel)
);

wire reg_w_wb;
wire [31:0]wd_wb;
wire [4:0]rd_addr_wb;
wire [31:0]rs1_data;
wire [31:0]rs2_data;
Register register(
	.clk(clk),.rst(rst),
	.rs1_addr(instr_id[`sig_Rs1]),.rs2_addr(instr_id[`sig_Rs2]),.reg_w(reg_w_wb),.wd(wd_wb),.rd_addr(rd_addr_wb),

	.rs1_data(rs1_data),.rs2_data(rs2_data)
);

/* ID_EX */
wire [31:0]pc_ex;
wire [31:0]imm_ex;
wire [6:0]opcode_ex;

wire pc_src_ex;
wire reg_w_ex;
wire wb_sel_ex;
wire rd_src_ex;
wire mem_w_ex;

wire [2:0]funct3_ex;
wire [`ALU_SIZE-1:0]alu_ctrl_ex;
wire alu_in2_sel_ex;

wire [31:0]rs1_data_ex;
wire [31:0]rs2_data_ex;

wire [4:0]rs1_addr_ex;
wire [4:0]rs2_addr_ex;
wire [4:0]rd_addr_ex;

ID_EX_reg id_ex(
	.clk(clk),.rst(rst),.sf(ID_EX_sf),
	.pc_in(pc_id),.imm_in(imm),.opcode_in(instr_id[`sig_Opcode]),
	.pc_src_in(pc_src),.reg_w_in(reg_w),.wb_sel_in(wb_sel),.rd_src_in(rd_src),.mem_r_in(mem_r),.mem_w_in(mem_w),
	.funct3_in(instr_id[`sig_Funct3]),.alu_ctrl_in(alu_ctrl),.alu_in2_sel_in(alu_in2_sel),
	.rs1_data_in(rs1_data),.rs2_data_in(rs2_data),.rs1_addr_in(instr_id[`sig_Rs1]),.rs2_addr_in(instr_id[`sig_Rs2]),.rd_addr_in(instr_id[`sig_Rd]),

	.pc_out(pc_ex),.imm_out(imm_ex),.opcode_out(opcode_ex),
	.pc_src_out(pc_src_ex),.reg_w_out(reg_w_ex),.wb_sel_out(wb_sel_ex),.rd_src_out(rd_src_ex),.mem_r_out(mem_r_ex),.mem_w_out(mem_w_ex),
	.funct3_out(funct3_ex),.alu_ctrl_out(alu_ctrl_ex),.alu_in2_sel_out(alu_in2_sel_ex),
	.rs1_data_out(rs1_data_ex),.rs2_data_out(rs2_data_ex),.rs1_addr_out(rs1_addr_ex),.rs2_addr_out(rs2_addr_ex),.rd_addr_out(rd_addr_ex)
);

/* EX */
Adder pc_adder_imm(
	.in1(pc_ex),.in2(imm_ex),
	.out(pc_branch)
);

wire [31:0]pc_next_ex;
Adder pc_adder_ex(
	.in1(pc_ex),.in2(32'd4),
	.out(pc_next_ex)
);

wire [31:0]pc_mux_out_ex;
Mux_2in pc_src_mux(
	.ctrl(pc_src_ex),.in0(pc_next_ex),.in1(pc_branch),
	.out(pc_mux_out_ex)
);

wire reg_w_mem;
wire [4:0]rd_addr_mem;
wire [4:0]rs2_addr_mem;
wire mem_w_mem;
wire [1:0]alu_in1_forward;
wire [1:0]alu_in2_forward;
wire mem_forward;
Forward_control forward_control(
	.rs1_addr(rs1_addr_ex),.rs2_addr(rs2_addr_ex),
	.reg_w_wb(reg_w_wb),.rd_addr_wb(rd_addr_wb),
	.reg_w_mem(reg_w_mem),.mem_w_mem(mem_w_mem),.rs2_addr_mem(rs2_addr_mem),.rd_addr_mem(rd_addr_mem),
	
	.alu_in1_forward(alu_in1_forward),.alu_in2_forward(alu_in2_forward),.mem_forward(mem_forward)
);

wire [31:0]wd_mem;
wire [31:0]alu_in1;
Mux_3in rs1_forward_mux(
	.ctrl(alu_in1_forward),.in0(rs1_data_ex),.in1(wd_wb),.in2(wd_mem),
	.out(alu_in1)
);

wire [31:0]rs2_data_forward;
Mux_3in rs2_forward_mux(
	.ctrl(alu_in2_forward),.in0(rs2_data_ex),.in1(wd_wb),.in2(wd_mem),
	.out(rs2_data_forward)
);

wire [31:0]alu_in2;
Mux_2in alu_in2_mux(
	.ctrl(alu_in2_sel_ex),.in0(rs2_data_forward),.in1(imm_ex),
	.out(alu_in2)
);

wire branch_flag;
ALU alu(
	.alu_ctrl(alu_ctrl_ex),.alu_in1(alu_in1),.alu_in2(alu_in2),
	.branch_flag(branch_flag),.alu_out(alu_out)
);

Branch_control branch_control(
	.opcode(opcode_ex),.branch_flag(branch_flag),
	.branch_ctrl(branch_ctrl)
);

/* EX_MEM */
wire [31:0]pc_mem;
wire wb_sel_mem;
wire rd_src_mem;
wire mem_r_mem;

wire [2:0]funct3_mem;
wire [31:0]alu_out_mem;
wire [31:0]rs2_data_mem;
EX_MEM_reg ex_mem(
	.clk(clk),.rst(rst),.sf(EX_MEM_sf),
	.pc_in(pc_mux_out_ex),.reg_w_in(reg_w_ex),.wb_sel_in(wb_sel_ex),.rd_src_in(rd_src_ex),.mem_r_in(mem_r_ex),.mem_w_in(mem_w_ex),
	.funct3_in(funct3_ex),.alu_out_in(alu_out),.rs2_data_in(rs2_data_forward),.rs2_addr_in(rs2_addr_ex),.rd_addr_in(rd_addr_ex),

	.pc_out(pc_mem),.reg_w_out(reg_w_mem),.wb_sel_out(wb_sel_mem),.rd_src_out(rd_src_mem),.mem_r_out(mem_r_mem),.mem_w_out(mem_w_mem),
	.funct3_out(funct3_mem),.alu_out_out(alu_out_mem),.rs2_data_out(rs2_data_mem),.rs2_addr_out(rs2_addr_mem),.rd_addr_out(rd_addr_mem)
);

/* MEM */
wire [31:0]rd_mux_mem;
Mux_2in rd_mux(
	.ctrl(rd_src_mem),.in0(alu_out_mem),.in1(pc_mem),
	.out(rd_mux_mem)
);

wire [31:0]rs2_forward_data;
Mux_2in mem_forward_mux(
	.ctrl(mem_forward),.in0(rs2_data_mem),.in1(wd_wb),
	.out(rs2_forward_data)
);

wire [31:0]rb_data_out;
DM_control dm_control(
	.mem_w(mem_w_mem),.funct3(funct3_mem),.mem_addr(alu_out_mem),.data(rs2_forward_data),.rb_data_in(dm_data_out),
	.rb_data_out(rb_data_out),.write_bits(dm_write_en),.w_data(dm_data_in)
);

Mux_2in wd_forward_mem(
	.ctrl(mem_r_mem),.in0(rd_mux_mem),.in1(rb_data_out),
	.out(wd_mem)
);

assign dm_addr = alu_out_mem[15:2];

/* MEM_WB */

wire wb_sel_wb;
wire [31:0]rd_data_wb;
wire [31:0]rb_data_wb;
MEM_WB_reg mem_wb(
	.clk(clk),.rst(rst),.sf(MEM_WB_sf),
	.reg_w_in(reg_w_mem),.wb_sel_in(wb_sel_mem),.rd_data_in(rd_mux_mem),.rb_data_in(rb_data_out),.rd_addr_in(rd_addr_mem),

	.reg_w_out(reg_w_wb),.wb_sel_out(wb_sel_wb),.rd_data_out(rd_data_wb),.rb_data_out(rb_data_wb),.rd_addr_out(rd_addr_wb)
);

/* WB */
Mux_2in wb_mux(
	.ctrl(wb_sel_wb),.in0(rb_data_wb),.in1(rd_data_wb),
	.out(wd_wb)
);

endmodule
