module score_addr(score,vc,addr_sc1,addr_sc2,addr_sc3,addr_sc4,addr_sc5);
input [16:0]score;
input[9:0]vc;
output reg [7:0] addr_sc1,addr_sc2,addr_sc3,addr_sc4,addr_sc5;
reg [3:0]sc_1,sc_2,sc_3,sc_4,sc_5;
reg [13:0]temp_1;
reg [9:0]temp_2;
reg [6:0]temp_3;
reg [3:0]mn;
always@(score)
begin
//eg:score=54321
 sc_1<=score%10;//outputs 1
 temp_1<=score/10;//outputs 5432
 sc_2<=temp_1%10; //outputs 2
 temp_2<=temp_1/10;//outputs 543
 sc_3<=temp_2%10; //outputs 3
 temp_3<=temp_2/10;//outputs 54
 sc_4<=temp_3%10;//outputs 4
 sc_5<=temp_3/10; //outputs 5
end
////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////
always@(vc)
begin
mn=(vc-7'd100);
end

///////////////////////////address////////////////////////////
always @(sc_1,sc_2,sc_3,sc_4,sc_5,mn)
begin
addr_sc1<={sc_1,mn};
addr_sc2<={sc_2,mn};
addr_sc3<={sc_3,mn};
addr_sc4<={sc_4,mn};
addr_sc5<={sc_5,mn};
end
endmodule