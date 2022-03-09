module Sign_Extend(
input wire [15:0] Inst,
output reg [31:0] SignImm
);
always @(*) begin
    if(Inst[15]==1'b0)
    SignImm={ {16{1'b0} },Inst};
    else
    SignImm={ {16{1'b1}},Inst};
end
endmodule