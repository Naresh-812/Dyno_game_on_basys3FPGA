module clk_100Hz(input clk_25MHz, output reg clk_100Hz);
    reg [17:0] count = 0;
    always @(posedge clk_25MHz) begin
        if (count == 18'd249999) begin
            clk_100Hz <= ~clk_100Hz;
            count <= 0;
        end else
            count <= count + 1;
    end
endmodule