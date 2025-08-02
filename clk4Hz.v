module clk4Hz(clk_16Hz,clk_4Hz);
input clk_16Hz;
output reg clk_4Hz=1'b0;
reg count=2'd0;

always@(posedge clk_16Hz)
begin
    if(count==1'b1)
    begin
    clk_4Hz<=~clk_4Hz;
    count<=1'd0;
    end
    else
    count<=1'b1;
end

endmodule