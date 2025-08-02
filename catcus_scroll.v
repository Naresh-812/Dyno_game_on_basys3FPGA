module catcus_scroll(clk_16Hz,freeze,s1,s2,s3,s4,s5,s6);
  input clk_16Hz,freeze;
  output reg [10:0] s1=11'd690;
  output  reg [10:0]s2=11'd690;
  output  reg [10:0] s3=11'd690;
  output  reg [10:0] s4=11'd690;
  output  reg [10:0] s5=11'd690;
  output reg [10:0] s6=11'd710;
  reg start=1'b1;
  reg start1,start2,start3,start4,start5;
   
    always@(posedge clk_16Hz)
    begin
    if(s6==11'd240)
    start<=1'b1;
    
    if(freeze)
    s1<=s1; 
    else if(start)
    begin
    s1<=s1-3'd5; 
    end
    
    if(s1==11'd0)
    begin
    start<=1'b0;
    s1<=11'd690;
    end
    
    if(s1==11'd240)
      start1<=1'b1;
      
    if(s2==11'd0)
      begin
      s2<=11'd690;
      start1<=1'b0;
      end
    else if(freeze)
    s2<=s2;
    else if(start1)
      s2<=s2-3'd5;
      
    if(s2==11'd240)
       start2<=1'b1;
    
    
    if(s3==11'd0)
    begin
    s3<=11'd690;
    start2<=1'b0;
    end
    else if(freeze)
    s3<=s3;
    else if(start2)
    s3<=s3-3'd5;
    
    
    if(s3==11'd240)
    start3<=1'b1;
    
    if(s4==11'd0)
    begin
    s4<=11'd690;
    start3<=1'b0;
    end
    else if(freeze)
    s4<=s4;
    else if(start3)
    s4<=s4-3'd5;
    
    
    
    if(s4==11'd240)
    start4<=1'b1;
    
    if(s5==11'd0)
    begin
    s5<=11'd690;
    start4<=1'b0;
    end
    else if(freeze)
    s5<=s5; 
    else if(start4)
    s5<=s5-3'd5;
    
    
    if(s5==11'd240)
    start5<=1'b1;
    
    if(s6==11'd0)
    begin
    s6<=11'd690;
    start5<=1'b0;
    end
    else if(freeze)
    s6<=s6; 
    else if(start5)
    s6<=s6-3'd5;
    
    end
endmodule
