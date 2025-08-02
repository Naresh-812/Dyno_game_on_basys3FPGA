module clk25MHz(clk,clk_25MHz);
input clk;
output reg clk_25MHz=1'b0;
reg count=1'b0;

always@(posedge clk)
    begin
    if(count==1'b1)
        begin
        clk_25MHz<=~clk_25MHz;
        count<=1'b0;
        end
    else
        count<=1'b1;
        
    end
endmodule
