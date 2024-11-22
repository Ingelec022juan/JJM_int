module Fast_PWM(
    input wire clk,
    input wire reset,
    input wire [31:0] timer_top,
    input wire [31:0] pwm_cnta,
    input wire [31:0] pwm_cntb,
    output reg pwm_outa,
    output reg pwm_outb
);

    reg [31:0] pwm_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pwm_counter <= 0;
            pwm_outa <= 0;
            pwm_outb <= 0;
        end else begin
            if (pwm_counter < timer_top) begin
                pwm_counter <= pwm_counter + 1;
            end else begin
                pwm_counter <= 0;
            end

            pwm_outa <= (pwm_counter < pwm_cnta) ? 1'b1 : 1'b0;
            pwm_outb <= (pwm_counter < pwm_cntb) ? 1'b1 : 1'b0;
        end
    end

endmodule
