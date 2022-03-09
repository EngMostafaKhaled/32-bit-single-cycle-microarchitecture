module ALU(
input wire [31:0] SrcA,SrcB,
input wire [2:0] ALUControl,
output reg [31:0] ALUResult,
output reg Zero
);
always @(*) 
begin
case(ALUControl)
3'b000:ALUResult=SrcA&SrcB;
3'b001:ALUResult=SrcA|SrcB;
3'b010:ALUResult=SrcA+SrcB;
3'b100:ALUResult=SrcA-SrcB;
3'b101:ALUResult=SrcA*SrcB;
3'b110:begin if (SrcA<SrcB)
               ALUResult=32'd1;
             else
               ALUResult=32'd0;
         end
default:ALUResult=32'd0;
endcase
end 
always @(*) begin
if (ALUResult==32'd0)
 Zero<=1;
else 
 Zero<=0;  
end
endmodule