module y4up(
    input clk_16Hz,
    input freeze,
    input up,
    output reg [6:0] y = 7'd0
);
    reg jumping = 0;
    reg [6:0] jump_count = 0;

    reg prev_up = 0;   // Store previous state of 'up'

    always @(posedge clk_16Hz) begin
        if (!freeze) begin
            // Detect rising edge: current up == 1, previous == 0
            if (up && !prev_up && !jumping) begin
                jumping <= 1;
                jump_count <= 1;
                y<=10;
            end else if (jumping) begin
                jump_count <= jump_count + 1;
                if (jump_count < 21)
                    y <= y + 4;
                //else if (jump_count < 64)
                 //   y <= y - 1;
                else begin
                    jumping <= 0;
                    y <= 0;
                end
            end else begin
                y <= 0;
            end
        end

        // Update previous up value at every cycle
        prev_up <= up;
    end
endmodule
