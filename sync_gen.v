module sync_gen(hc,vc,hsync,vsync);
input [9:0]hc,vc;
output reg hsync,vsync;
always @*
begin
hsync=((hc>=10'd656)&&(hc<=10'd751))?1'b0:1'b1;
vsync=((vc>=10'd513)&&(vc<=10'd514))?1'b0:1'b1;
end
endmodule
