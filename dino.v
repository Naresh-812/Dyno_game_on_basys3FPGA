module dino(clk,up1,down,hsync,vsync,r,g,b);
//----------------------------------------port declarations------------------------------------------------
input clk; //100 MHz clock input from FPGA
input up1;//signal to make dino jump 
input down;//signal to make dino bend
output hsync,vsync;//vsync and hysnc for conveying monitor when to move to next row or column
output reg [3:0] r,g,b;//rgb color each four bit 2^4=16 , 16x16x16=4096 colors can be displayed using VGA
//----------------------------------------------------------------------------------------------------------

//-------------------------------module instantations and wires------------------------------------------------
wire up;
wire clk_1Hz;
wire clk_25MHz;
wire clk_100Hz;
wire clk_4Hz;
wire clk_16Hz;
clk25MHz c011(clk,clk_25MHz);
clk16Hz c12(clk_25MHz,clk_16Hz);
clk4Hz c11(clk_16Hz,clk_4Hz);
clk1Hz c4(clk_4Hz,clk_1Hz);



up_logic u0(up1,clk_16Hz,up);

clk_100Hz c0112(clk_25MHz,clk_100Hz);
wire [9:0]hc;
wire [9:0]vc;
hcounter h(clk_25MHz,hc);
vcounter v(clk_25MHz,vc,hc);
sync_gen s(hc,vc,hsync,vsync);
wire[699:0]outl;
line_rom l(vc,outl);

wire btn_debounced;
wire jump_trigger;

debounce db_inst (
    .clk(clk_100MHz),     // Your main fast clock
    .btn_in(up1),         // Raw button
    .btn_out(btn_debounced)
);

up_logic uplogic_inst (
    .btn_clean(btn_debounced),
    .clk_16Hz(clk_16Hz),  // A slower clock
    .up(jump_trigger)
);

wire t,freeze;
toggle t0(clk_4Hz,freeze,t);
wire [5:0]y;

y4up y0(clk_16Hz,freeze,up,y);
wire [11:0]addr_dino;
dino_addr d0(t,vc,y,addr_dino);
wire [21:0] outd;
dino_rom d1(clk,addr_dino,outd);
wire [0:49]outdd;
dinodown_rom d2(vc,outdd);

wire [16:0]score;
score_gen s0(clk_1Hz,freeze,score);
wire [7:0]addr_sc1,addr_sc2,addr_sc3,addr_sc4,addr_sc5;
score_addr s01(score,vc,addr_sc1,addr_sc2,addr_sc3,addr_sc4,addr_sc5);
wire [0:7]datas1,datas2,datas3,datas4,datas5;
score_rom s02(addr_sc1,datas1);
score_rom s03(addr_sc2,datas2);
score_rom s04(addr_sc3,datas3);
score_rom s05(addr_sc4,datas4);
score_rom s06(addr_sc5,datas5);
wire [0:46]datas;
scorename_rom s7(vc,datas);
wire[0:249]outg;
gameover_rom g0(vc,outg);

wire [11:0]addrb;
wire [0:49]outb;
bird_rom b0(addrb,outb);
wire[10:0]s1,s2,s3,s4,s5,s6;
catcus_scroll ca1(clk_16Hz,freeze,s1,s2,s3,s4,s5,s6);
wire [11:0]addrtr1,addrtr2,addrtr3,addrtr4,addrtr5;
catcus_addr ca2(vc,addrtr1,addrtr2,addrtr3,addrtr4,addrtr5);
bird_addr b1(t,vc,addrb);

wire[0:39]outtr1,outtr2,outtr3,outtr4,outtr5;
catcus_rom ca3(addrtr1,outtr1);
catcus_rom ca4(addrtr2,outtr2);
catcus_rom ca5(addrtr3,outtr3);
catcus_rom ca6(addrtr4,outtr4);
catcus_rom ca7(addrtr5,outtr5);

freeze_logic f(clk_16Hz,up,down,y,s1,s2,s3,s4,s5,s6,freeze);
wire[0:69] outc0,outc1,outc2;
reg [10:0]c00=11'd135;
reg [10:0]c01=11'd180;
reg [10:0] c02=11'd230;
wire [10:0]c0,c1,c2;
assign c0=c00;
assign c1=c01;
assign c2=c02;
cloud_rom c10(vc,c0,outc0);
cloud_rom cl1(vc,c1,outc1);
cloud_rom cl2(vc,c2,outc2);
wire [10:0] hc2,hc1,hc0;
cloud_scroll c13(clk_16Hz,freeze,hc2,hc1,hc0);


//--------------------------------------printing objects on screen---------------------------------
always@(hc,vc)
begin
        //line
        if(hc>=11'd0 && hc<=11'd699 && vc>=11'd400 && vc<=11'd409 && outl[hc])
            begin
r = 4'b1010; // Medium-high red (10)
g = 4'b0101; // Low green (5)
b = 4'b0010; // Very low blue (2)
            end
         //dino
         else if(hc>=10'd150 && hc<10'd172 && vc>=10'd354-y && vc<10'd402-y && !down && outd[hc-10'd150])
         begin
             r=4'b1111;
             g=4'b1111;
             b=4'b1111;
         end
         //dino down
         else if(hc>=10'd150 && hc<10'd200 && vc>=10'd374 && vc<10'd402+y && down && outdd[hc-10'd150] && !freeze)
                  begin
                      r=4'b1111;
                      g=4'b1111;
                      b=4'b1111;
                  end
         //score 
         else if(hc>=10'd492 && hc<=10'd499 && vc>=10'd100 && vc<=10'd115 && datas1[hc-10'd492])//ones place  
         begin
          r=4'b1111;
          g=4'b1111;
          b=4'b1111;
         end    
         else if(hc>=10'd482 && hc<=10'd489 && vc>=10'd100 && vc<=10'd115 && datas2[hc-10'd482])//tens place  
                 begin
                  r=4'b1111;
                  g=4'b1111;
                  b=4'b1111;
                 end   
           else if(hc>=10'd472 && hc<=10'd479 && vc>=10'd100 && vc<=10'd115 && datas3[hc-10'd472])//hundreds place  
                         begin
                          r=4'b1111;
                          g=4'b1111;
                          b=4'b1111;
                         end    
          else if(hc>=10'd462 && hc<=10'd469 && vc>=10'd100 && vc<=10'd115 && datas4[hc-10'd462])//thousands place  
                                 begin
                                  r=4'b1111;
                                  g=4'b1111;
                                  b=4'b1111;
                                 end    
        else if(hc>=10'd452 && hc<=10'd459 && vc>=10'd100 && vc<=10'd115 && datas4[hc-10'd452])//ten thousands place  
                                  begin
                                   r=4'b1111;
                                   g=4'b1111;
                                    b=4'b1111;
                                   end    
         else if(hc>=10'd403 && hc<=10'd450 && vc>=10'd100 && vc<=10'd115 && datas[hc-10'd403])//namescore
                                   begin
                                    r=4'b1111;
                                    g=4'b1111;
                                    b=4'b1111;
                                   end  
                                   
          else if(hc>=10'd150 && hc<=10'd400 && vc>=10'd150 && vc<=10'd267 && outg[hc-10'd150]&& freeze)//gameover
                                                                     begin
                                                                      r=4'b1111;
                                                                      g=4'b1111;
                                                                      b=4'b1111;
                                                                     end    
                                                                     
     //obstacles
                                                                     
        else if((hc<=s1) & (hc>=s1-11'd40) & (vc >=11'd358) & (vc <=11'd400) & outtr1[hc-s1+11'd40])
                                   begin
                                   r=4'b0000;
                                   g=4'b1111;
                                   b=4'b0000;
                                  end    
                                                                                    
                                                                                               
                                                                                               
     else if((hc<=s2) & (hc>=s2-11'd40) & (vc >=11'd358) & (vc <=11'd400) & outtr2[hc-s2+11'd40])
                                                                                                                            
                                     begin
                                         r=4'b0000;
                                         g=4'b1111;
                                          b=4'b0000;
                                      end    
                                                                                                         
      else if((hc<=s3) & (hc>=s3-11'd40) & (vc >=11'd358) & (vc <=11'd400) & outtr3[hc-s3+11'd40])
                                       begin
                                           r=4'b0000;
                                           g=4'b1111;
                                            b=4'b0000;
                                        end   
             
         else if((hc<=s4) & (hc>=s4-11'd40) & (vc >=11'd358) & (vc <=11'd400) & outtr4[hc-s4+11'd40])
                                                          
                                            begin
                                           r=4'b0000;
                                           g=4'b1111;
                                           b=4'b0000;
                                            end   
                                                                            
                                                                                                                                
     else if((hc<=s5) & (hc>=s5-11'd40) & (vc >=11'd358) & (vc <=11'd400) & outtr5[hc-s5+11'd40])
                                begin
                                     r=4'b0000;
                                     g=4'b1111;
                                      b=4'b0000;
                                  end   


    /////////////////////////////////printing bird//////////////////////////////////
                                                                                                       
    else if((hc<=s6) & (hc>=s6-11'd50) & (vc >=11'd332) & (vc <=11'd370) & outb[hc-s6+11'd50])
                                         begin
                                        r=4'b1111;
                                        g=4'b1111;
                                         b=4'b1111;
                                     end   
    
     ///////////////////////////////////////////printing cloud/////////////////////////////////////////////
     else if((hc<=hc0) & (hc>=hc0-11'd70) & (vc >=c0) & (vc <=c0+38) & outc0[hc-hc0+11'd70])      
                         begin      
        r = 4'b0010; // Low red
        g = 4'b1000; // Medium green
        b = 4'b1111; // High blue
                                 end
                               
    else if((hc<=hc1) & (hc>=hc1-11'd70) & (vc >=c1) & (vc <=c1+38) & outc1[hc-hc1+11'd70])
                                               begin        
                                   r = 4'b0010; // Low red
                                   g = 4'b1000; // Medium green
                                     b = 4'b1111; // High blue

                                                end

    else if((hc<=hc2) & (hc>=hc2-11'd70) & (vc >=c2) & (vc <=c2+38) & outc2[hc-hc2+11'd70])
                                        begin      
     r = 4'b0010; // Low red
g = 4'b1000; // Medium green
b = 4'b1111; // High blue

                                         end

        else 
           begin
            r=4'h0;
            g=4'h0;
            b=4'h0;
           end
end

endmodule