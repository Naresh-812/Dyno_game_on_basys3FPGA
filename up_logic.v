module up_logic (
    input btn_clean,
    input clk_16Hz,
    output reg up = 0
);
    reg prev_btn = 0;

    always @(posedge clk_16Hz) begin
        if (btn_clean && !prev_btn)
            up <= 1;
        else
            up <= 0;

        prev_btn <= btn_clean;
    end
endmodule
