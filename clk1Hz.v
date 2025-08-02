module clk1Hz(clk_4Hz,clk_1Hz);
input clk_4Hz;
output reg clk_1Hz;
reg count=1'b0;
always @(posedge clk_4Hz)
begin
    if(count==1'b1)
    begin
    clk_1Hz<=~clk_1Hz;
    count<=1'b0;
    end
    else
    count<=1'b1;
end
endmodule
