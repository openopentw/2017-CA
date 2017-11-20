module Control(
    Op_i,
    RegDst_o,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o
);

input	[5:0]	Op_i;
output			RegDst_o, ALUSrc_o, RegWrite_o;
output	[1:0]	ALUOp_o;

// Op_i[3] == 1 if I-type
assign RegDst_o = ~Op_i[3];
assign ALUOp_o = {1'b0, Op_i[3]};
assign ALUSrc_o = Op_i[3];

assign RegWrite_o = 1'b1;

endmodule
