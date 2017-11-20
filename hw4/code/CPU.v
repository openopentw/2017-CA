module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input			clk_i;
input			rst_i;
input			start_i;

wire	[31:0]	inst_addr;
wire	[31:0]	inst;
wire			ctrl_regdst;
wire	[1:0]	ctrl_aluop;
wire			ctrl_alusrc;
wire			ctrl_regwrite;
wire	[31:0]	pc_i;
wire	[4:0]	regdst_o;
wire	[31:0]	aluop_o;
wire	[31:0]	alusrc_o;
wire	[31:0]	rsData_o;
wire	[31:0]	rtData_o;
wire	[31:0]	imm32;
wire	[2:0]	aluctrl;

Control Control(
    .Op_i       (inst[31:26]),
    .RegDst_o   (ctrl_regdst),
    .ALUOp_o    (ctrl_aluop),
    .ALUSrc_o   (ctrl_alusrc),
    .RegWrite_o (ctrl_regwrite)
);

Adder Add_PC(
    .data1_i    (inst_addr),
    .data2_i    (32'd4),
    .data_o     (pc_i)
);

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (pc_i),
    .pc_o       (inst_addr)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (inst_addr),
    .instr_o    (inst)
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (inst[25:21]),
    .RTaddr_i   (inst[20:16]),
    .RDaddr_i   (regdst_o),
    .RDdata_i   (aluop_o),
    .RegWrite_i (ctrl_regwrite),
    .RSdata_o   (rsData_o),
    .RTdata_o   (rtData_o)
);

MUX5 MUX_RegDst(
    .data1_i    (inst[20:16]),
    .data2_i    (inst[15:11]),
    .select_i   (ctrl_regdst),
    .data_o     (regdst_o)
);

MUX32 MUX_ALUSrc(
    .data1_i    (rtData_o),
    .data2_i    (imm32),
    .select_i   (ctrl_alusrc),
    .data_o     (alusrc_o)
);

Sign_Extend Sign_Extend(
    .data_i     (inst[15:0]),
    .data_o     (imm32)
);

ALU ALU(
    .data1_i    (rsData_o),
    .data2_i    (alusrc_o),
    .ALUCtrl_i  (aluctrl),
    .data_o     (aluop_o),
    .Zero_o     ()
);

ALU_Control ALU_Control(
    .funct_i    (inst[5:0]),
    .ALUOp_i    (ctrl_aluop),
    .ALUCtrl_o  (aluctrl)
);

endmodule
