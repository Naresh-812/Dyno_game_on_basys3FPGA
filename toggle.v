module toggle(clk_4Hz,freeze,t);
input wire clk_4Hz;
input wire freeze;
output reg t=1'b0;
always @(posedge clk_4Hz) begin
    if (!freeze) begin
        t <= ~t;
    end
    else t<=t;// When freeze is asserted, 't' retains its value implicitly
end
endmodule
