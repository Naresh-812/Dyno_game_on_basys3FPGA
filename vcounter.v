module vcounter(clk_25MHz,vc,hc);
input clk_25MHz;
input [9:0] hc;
output reg [10:0]vc=10'd0;
always@(posedge clk_25MHz)
    begin
    
     if(hc==10'd799)
        begin
          if(vc==10'd524)
             vc<=10'd0;
          else 
             vc<=vc+1'b1;
        end
end
endmodule
