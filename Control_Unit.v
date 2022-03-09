module Control_Unit(
input wire [5:0] Opcode,Funct,
input wire Zero,
output reg MemtoReg,MemWrite,ALUSrc,RegDst,RegWrite,Jump,
output reg [2:0] ALUControl,
output wire PCSrc,
output reg [1:0] ALUOP
);
reg Branch;
assign PCSrc=Branch&Zero;
always @(*) begin
case (ALUOP)
2'b00: ALUControl=3'b010;
2'b01: ALUControl=3'b100;
2'b10: begin case(Funct)
/*add*/ 6'b10_0000:ALUControl=3'b010;
/*sub*/ 6'b10_0010:ALUControl=3'b100;
/*slt*/ 6'b10_1010:ALUControl=3'b110;
/*mul*/ 6'b01_1100:ALUControl=3'b101; 
              default:ALUControl=3'b010;
              endcase
        end
default:ALUControl=3'b010;
endcase    
end
always @(*) begin
Jump=1'b0;
MemtoReg=1'b0;
MemWrite=1'b0;
Branch=1'b0;
ALUSrc=1'b0;
RegDst=1'b0;
RegWrite=1'b0;
ALUOP=2'b00;
    case(Opcode)
    6'b10_0011: begin //load_word
        RegWrite=1'b1;
        ALUSrc=1'b1;
        MemtoReg=1'b1;
    end
    6'b10_1011: begin //store_word
        MemWrite=1'b1;
        ALUSrc=1'b1;
        MemtoReg=1'b1;
    end
    6'b00_0000: begin //rType
        RegDst=1'b1;
        RegWrite=1'b1;
        ALUOP=2'b10;
    end
    6'b00_1000: begin //addImmediate
        RegWrite=1'b1;
        ALUSrc=1'b1;
    end
    6'b00_0100: begin //branchIfEqual
        ALUOP=2'b01;
        Branch=1'b1;
    end
    6'b00_0010 : begin // jump_inst  
        Jump=1'b1;
    end
    default: begin
        Jump=1'b0;
        MemtoReg=1'b0;
        MemWrite=1'b0;
        Branch=1'b0;
        ALUSrc=1'b0;
        RegDst=1'b0;
        RegWrite=1'b0;
        ALUOP=2'b00;
    end
    endcase
end
endmodule