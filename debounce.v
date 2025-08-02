module debounce(
    input clk,            // Fast clock, like 100 MHz
    input btn_in,
    output reg btn_out
);

    reg [19:0] count = 0;
    reg btn_sync_0 = 0, btn_sync_1 = 0;

    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;
    end

    wire stable = (btn_sync_0 == btn_sync_1);

    always @(posedge clk) begin
        if (stable) begin
            if (count < 1_000_000)
                count <= count + 1;
            else
                btn_out <= btn_sync_1;
        end else begin
            count <= 0;
        end
    end
endmodule