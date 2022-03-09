module DataPath(
input wire MemtoReg,ALUSrc,RegDst,RegWrite,Jump,PCSrc,clk,rst,//Contrl_Unit
input wire [2:0] ALUControl,//Contrl_Unit
input wire [31:0] Instr,RD,//ROM,RAM
output wire [31:0] WriteData,ALUResult,PC,Zero
);
wire [31:0] SrcA,SrcB,PCPlus4,PC_O,PC_Branch,Result,SignImm,Out_Shift,Out_Mux1;
wire [4:0] WriteReg;
Reg_File r_F0(
.clk(clk),
.rst(rst),
.RD1(SrcA),
.RD2(WriteData),
.WE(RegWrite),
.R_A1(Instr[25:21]),
.R_A2(Instr[20:16]),
.W_A(WriteReg),
.WD(Result)
);
ALU alu1(
.SrcA(SrcA),
.SrcB(SrcB),
.ALUResult(ALUResult),
.ALUControl(ALUControl),
.Zero(Zero)
);
Mux m1_alu(
.in1(WriteData),
.in2(SignImm),
.out(SrcB),
.sel(ALUSrc)
);
Mux m2_ram(
.in1(ALUResult),
.in2(RD),
.out(Result),
.sel(MemtoReg)
);
Mux m3_regfile(
.in1(Instr[20:16]),
.in2(Instr[15:11]),
.out(WriteReg),
.sel(RegDst)
);
Mux m4_ROM1(
.in1(PCPlus4),
.in2(PC_Branch),
.out(Out_Mux1),
.sel(PCSrc)
);
Mux m5_ROM2(
.in1(Out_Mux1),
.in2({PCPlus4[31:28],Instr[25:0],{2'b00}}),
.out(PC_O),
.sel(Jump)
);
Sign_Extend s1(
.Inst(Instr[15:0]),
.SignImm(SignImm)
);
shift_left_twice s1_signextend(
.in(SignImm),
.out(Out_Shift)
);
adder add_plus4(
.A(PC),
.B(32'd4),
.C(PCPlus4)
);
adder add_branch(
.A(Out_Shift),
.B(PCPlus4),
.C(PC_Branch)
);
PC pc1(
.rst(rst),
.clk(clk),
.PC_O(PC_O),
.PC_N(PC)
);
endmodule