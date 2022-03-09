module ROM ( 
input wire [31:0] PC,
output reg [31:0] Instr
);
reg[31:0] ROM[0:31];
initial begin
    $readmemh("Program 2_Machine Code.txt",ROM);
end
always @(*)
begin
     Instr<=ROM [PC>>2];
end
endmodule