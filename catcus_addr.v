module catcus_addr(vc,addrtr1,addrtr2,addrtr3,addrtr4,addrtr5);
input[9:0]vc;
output reg [11:0]addrtr1,addrtr2,addrtr3,addrtr4,addrtr5;
reg [7:0]kl;
always@(vc)
begin
kl=(vc-354);
end

///////////////////////////address////////////////////////////
always @(kl)
begin
addrtr1<={4'd1,kl};
addrtr2<={4'd2,kl};
addrtr3<={4'd3,kl};
addrtr4<={4'd4,kl};
addrtr5<={4'd5,kl};
end
endmodule