`timescale 1ns / 1ps

module Fast_PWM_tb;

    // Entradas
    reg clk;
    reg reset;
    reg [31:0] timer_top;
    reg [31:0] pwm_cnta;
    reg [31:0] pwm_cntb;

    // Salidas
    wire pwm_outa;
    wire pwm_outb;

    // Instancia del módulo a probar
    Fast_PWM uut (
        .clk(clk),
        .reset(reset),
        .timer_top(timer_top),
        .pwm_cnta(pwm_cnta),
        .pwm_cntb(pwm_cntb),
        .pwm_outa(pwm_outa),
        .pwm_outb(pwm_outb)
    );

    // Generación del reloj
    initial clk = 0;
    always #5 clk = ~clk; // Periodo de 10 ns (100 MHz)

    // Configuración del testbench
    initial begin
        // Configuración para generar el archivo .vcd
        $dumpfile("Fast_PWM.vcd");  // Nombre del archivo VCD
        $dumpvars(0, Fast_PWM_tb);  // Niveles a registrar

        // Inicialización
        reset = 1;             // Activar el reset al inicio
        timer_top = 32'd100;   // Valor máximo del contador
        pwm_cnta = 32'd50;     // Valor de comparación para salida A
        pwm_cntb = 32'd30;     // Valor de comparación para salida B
        #10 reset = 0;         // Desactivar el reset después de 10 ns

        // Simulación
        #500;  // Simular durante 500 ns

        // Finalizar simulación
        $stop; // Detener la simulación
    end

endmodule
