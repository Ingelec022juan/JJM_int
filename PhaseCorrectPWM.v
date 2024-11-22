module PhaseCorrectPWM(
    input wire clk,
    input wire reset,
    input wire [31:0] top,
    input wire [31:0] pwm_a,
    input wire [31:0] pwm_b,
    output reg pwm_outa,
    output reg pwm_outb
);

    reg [31:0] counter;
    reg direction; // 0 = ascendente, 1 = descendente

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            direction <= 0;
            pwm_outa <= 0;
            pwm_outb <= 0;
        end else begin
            if (direction == 0) begin
                if (counter < top) begin
                    counter <= counter + 1;
                end else begin
                    direction <= 1;
                end
            end else begin
                if (counter > 0) begin
                    counter <= counter - 1;
                end else begin
                    direction <= 0;
                end
            end

            pwm_outa <= (counter < pwm_a) ? 1'b1 : 1'b0;
            pwm_outb <= (counter < pwm_b) ? 1'b1 : 1'b0;
        end
    end

endmodule
