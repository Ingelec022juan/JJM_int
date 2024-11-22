module Timer_NormalMode(
    input wire clk,
    input wire reset,
    output reg irq_timer,
    output reg [31:0] timer_cnt
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            timer_cnt <= 32'b0;
            irq_timer <= 1'b0;
        end else begin
            timer_cnt <= timer_cnt + 1;
            if (timer_cnt == 32'hFFFFFFFF) begin
                irq_timer <= 1'b1; // Interrupción cuando el contador alcanza su límite
            end else begin
                irq_timer <= 1'b0;
            end
        end
    end

endmodule
