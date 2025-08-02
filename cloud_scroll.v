module cloud_scroll(clk_16Hz,freeze,hc2,hc1,hc0);
input clk_16Hz,freeze;
output reg [10:0]hc2=11'd750;
output reg [10:0]hc1=11'd750;
output reg [10:0]hc0=11'd750;

reg start_c0=1'b1;
reg start_c1,start_c2;
    always @(posedge clk_16Hz)
    begin
    if(hc2==11'd450)
    start_c0<=1'b1;
    
    if(freeze)
    hc0<=hc0; 
    else if(start_c0)
    begin
    hc0<=hc0-2'd3; 
    end
    
    if(hc0==11'd0)
    begin
    start_c0<=1'b0;
    hc0<=11'd750;
    end
    
    if(hc0==11'd450)
      start_c1<=1'b1;
      
    if(hc1==11'd0)
      begin
      hc1<=11'd750;
      start_c1<=1'b0;
      end
    else if(freeze)
    hc1<=hc1;
    else if(start_c1)
      hc1<=hc1-2'd3;
      
    if(hc1==11'd450)
       start_c2<=1'b1;
    
    
    if(hc2==11'd0)
    begin
    hc2<=11'd750;
    start_c2<=1'b0;
    end
    else if(freeze)
    hc2<=hc2;
    else if(start_c2)
    hc2<=hc2-2'd3;
    
    end

endmodule
