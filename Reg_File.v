module Reg_File(
input wire clk,rst,WE,
input wire [4:0] R_A1,R_A2,W_A,
input wire [31:0] WD,
output reg [31:0] RD1,RD2
);
reg [31:0] Reg_File [0:31] ;
integer i;
always @(posedge clk ,negedge rst)
 begin
    if(!rst)//reset
    begin
        for(i=0;i<32;i=i+1)
        begin
        Reg_File[i]<={32 {1'b0}};
        end
    end
     else if(WE)//write
        Reg_File[W_A]<=WD;
  end
  always@(*) begin
 RD1 = Reg_File[R_A1];      
  end
  always@(*) begin
 RD2 = Reg_File[R_A2];      
  end
endmodule