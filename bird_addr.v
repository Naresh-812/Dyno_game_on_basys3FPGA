module bird_addr(t,vc,addrb);
input t;
input [9:0]vc;
output reg [11:0]addrb;
reg [7:0]d;

always@(vc)
d<=vc-10'd332;

always @(d,t)
begin
addrb<={t,d};
end

endmodule
