module MIPS(
input wire clk,rst,
output wire [15:0] Test_Value
);
wire MemWrite,RegWrite,RegDst,ALUSrc,MemtoReg,PCSrc,Jump,Zero;  
wire [2:0] ALUControl;
wire [31:0] ALUResult,WriteData,RD,Instr,PC;

DataPath D1(
.clk(clk),
.rst(rst),
.Instr(Instr),
.RD(RD),
.WriteData(WriteData),
.ALUResult(ALUResult),
.PC(PC),
.Zero(Zero),
.MemtoReg(MemtoReg),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.Jump(Jump),
.ALUControl(ALUControl),
.PCSrc(PCSrc)
);
Control_Unit C_U1(
.Opcode(Instr[31:26]),
.Funct(Instr[5:0]),
.Zero(Zero),
.MemtoReg(MemtoReg),
.MemWrite(MemWrite),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.Jump(Jump),
.ALUControl(ALUControl),
.PCSrc(PCSrc)
);
RAM dM(
.clk(clk),
.rst(rst),
.WE(MemWrite),
.WD(WriteData),
.A(ALUResult),
.RD(RD),
.Test_Value(Test_Value)
);
ROM iM(
.PC(PC),
.Instr(Instr)
);
endmodule