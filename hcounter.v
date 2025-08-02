module hcounter(clk_25MHz,hc);
input clk_25MHz;
output reg [9:0]hc=10'd0;
always@(posedge clk_25MHz)
    begin
    if(hc==10'd799)
        hc<=10'd0;
    else 
        hc<=hc+1'b1;
end
endmodule

