module clk16Hz(clk_25MHz,clk_16Hz);
input clk_25MHz;
output reg clk_16Hz;
reg [19:0]count; //781250 can be least represented in 20 bits

always @(posedge clk_25MHz)
begin
    if(count==20'd781250)
    begin
    clk_16Hz<=~clk_16Hz;
    count<=20'd0;
    end
    else
    count<=count+1'b1;
end
endmodule
