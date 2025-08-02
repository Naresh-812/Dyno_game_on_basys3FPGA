module freeze_logic(
    input clk,
    input up,
    input down,
    input [5:0] y,
    input [10:0] s1, s2, s3, s4, s5, s6,
    output reg freeze
);
    reg [9:0] dino_x1 = 150;
    reg [9:0] dino_x2;
    reg [9:0] dino_y1;
    reg [9:0] dino_y2;
    reg [5:0] y_sync;

    // Collision wires declared outside the always block
    wire cactus_collision;
    wire bird_collision;

    // Assign collision logic combinationally
    assign cactus_collision = 
        ((s1 >= dino_x1 && s1 <= dino_x2) ||
         (s2 >= dino_x1 && s2 <= dino_x2) ||
         (s3 >= dino_x1 && s3 <= dino_x2) ||
         (s4 >= dino_x1 && s4 <= dino_x2) ||
         (s5 >= dino_x1 && s5 <= dino_x2)) &&
        (dino_y2 >= 370 && dino_y1 <= 400);

    assign bird_collision = 
        (s6 >= dino_x1 && s6 <= dino_x2) &&
        (dino_y2 >= 332 && dino_y1 <= 370);

    always @(posedge clk) begin
        y_sync <= y;

        // Update hitbox
        if (down) begin
            dino_x2 <= 200;
            dino_y1 <= 374;
            dino_y2 <= 402;
        end 
        else if (y_sync > 0) begin
            dino_x2 <= 160;
            dino_y1 <= 354 - y_sync;
            dino_y2 <= 402 - y_sync;
        end 
        else begin
            dino_x2 <= 162;
            dino_y1 <= 354;
            dino_y2 <= 402;
        end

        freeze <= cactus_collision || bird_collision;
    end
endmodule