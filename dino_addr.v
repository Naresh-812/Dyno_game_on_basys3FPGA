module dino_addr(t,vc,y,addr_dino);
input t;
input [9:0]vc;
input[5:0]y;
output reg [11:0]addr_dino;
reg [7:0]d;

always@(vc)
d<=vc-10'd354+y;

always @(d,t)
begin
addr_dino<={t,d};
end

endmodule
