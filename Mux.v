module Mux(
input wire [31:0] in1,in2,
output reg [31:0] out,
input wire sel
);
always @(*) begin
    if(sel==1'b0)
    out=in1;
    else
    out=in2;
end
endmodule