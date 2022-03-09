module RAM(
input wire clk,rst,WE,
input wire [31:0] WD,A,
output reg [31:0] RD,
output reg [15:0] Test_Value
);
reg [31:0] RAM [0:31] ;
integer i;
always @(posedge clk ,negedge rst)
 begin
    if(!rst)//reset
    begin
        for(i=0;i<31;i=i+1)
        begin
        RAM[i]<={32 {1'b0}};
        end
    end
     else if(WE)//write
        RAM[A]<=WD;
  end
  always@(*) begin
 RD = RAM[A];      
  end
  always @(*)
    begin
        Test_Value = RAM[0] ;
    end
endmodule
