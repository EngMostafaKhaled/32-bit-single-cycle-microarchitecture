module PC(
input wire [31:0] PC_O,
input wire clk,rst,
output reg [31:0] PC_N
);
always @(posedge clk , negedge rst)
 begin
   if(!rst)
   PC_N<=32'b0;
   else
   PC_N<= PC_O;
end
endmodule