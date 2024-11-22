module Timer_PWM_Generator(
    input wire clk,                // Reloj principal
    input wire reset,              // Señal de reinicio
    input wire [1:0] TMR_SRC,      // Fuente del temporizador: 00=Disabled, 01=CPU Clock, 10=GPIO
    input wire [1:0] TMR_MODE,     // Modo del temporizador: 00=Normal, 01=Fast PWM, 10=Phase Correct
    input wire [31:0] TIMER_TOP,   // Valor máximo del contador
    input wire [31:0] PWM_CNTA,    // Valor de comparación para salida A
    input wire [31:0] PWM_CNTB,    // Valor de comparación para salida B
    output reg PWM_OUTA,           // Salida PWM A
    output reg PWM_OUTB,           // Salida PWM B
    output reg timer_interrupt     // Señal de interrupción
);

    // Señales internas
    wire irq_timer_normal;
    wire pwm_outa_fast, pwm_outb_fast;
    wire pwm_outa_phase, pwm_outb_phase;
    wire [31:0] timer_cnt_normal_wire;
    reg [31:0] timer_cnt_normal;

    // Instancia del módulo Timer_NormalMode
    Timer_NormalMode normal_mode_inst (
        .clk(clk),
        .reset(reset),
        .irq_timer(irq_timer_normal),
        .timer_cnt(timer_cnt_normal_wire)
    );

    // Registro del contador en modo normal
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            timer_cnt_normal <= 0;
        end else begin
            timer_cnt_normal <= timer_cnt_normal_wire;
        end
    end

    // Instancia del módulo Fast_PWM
    Fast_PWM fast_pwm_inst (
        .clk(clk),
        .reset(reset),
        .pwm_outa(pwm_outa_fast),
        .pwm_outb(pwm_outb_fast),
        .timer_top(TIMER_TOP),
        .pwm_cnta(PWM_CNTA),
        .pwm_cntb(PWM_CNTB)
    );

    // Instancia del módulo PhaseCorrectPWM
    PhaseCorrectPWM phase_pwm_inst (
        .clk(clk),
        .reset(reset),
        .top(TIMER_TOP),
        .pwm_a(PWM_CNTA),
        .pwm_b(PWM_CNTB),
        .pwm_outa(pwm_outa_phase),
        .pwm_outb(pwm_outb_phase)
    );

    // Multiplexor para seleccionar el modo de operación
    always @(*) begin
        case (TMR_MODE)
            2'b00: begin
                PWM_OUTA = 0;
                PWM_OUTB = 0;
                timer_interrupt = irq_timer_normal;
            end
            2'b01: begin
                PWM_OUTA = pwm_outa_fast;
                PWM_OUTB = pwm_outb_fast;
                timer_interrupt = 0;
            end
            2'b10: begin
                PWM_OUTA = pwm_outa_phase;
                PWM_OUTB = pwm_outb_phase;
                timer_interrupt = 0;
            end
            default: begin
                PWM_OUTA = 0;
                PWM_OUTB = 0;
                timer_interrupt = 0;
            end
        endcase
    end

endmodule
