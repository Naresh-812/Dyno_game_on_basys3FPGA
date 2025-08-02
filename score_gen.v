module score_gen(clk_1Hz,freeze,score);
input clk_1Hz;
input freeze;
output reg [16:0]score=17'd0;

always @(posedge clk_1Hz)
begin
if(score==17'd99999)
score<=17'd0;
else if(freeze)
score<=score; 
else
score<=score+1'b1;
end
/////////////////////////////////////////////////////////////////////////////////////////////
endmodule