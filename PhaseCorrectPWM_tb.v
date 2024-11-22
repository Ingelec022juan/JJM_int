`timescale 1ns / 1ps

module PhaseCorrectPWM_tb;

    // Entradas
    reg clk;
    reg reset;
    reg [31:0] top;
    reg [31:0] pwm_a;
    reg [31:0] pwm_b;

    // Salidas
    wire pwm_outa;
    wire pwm_outb;

    // Instancia del módulo a probar
    PhaseCorrectPWM uut (
        .clk(clk),
        .reset(reset),
        .top(top),
        .pwm_a(pwm_a),
        .pwm_b(pwm_b),
        .pwm_outa(pwm_outa),
        .pwm_outb(pwm_outb)
    );

    // Generación del reloj
    initial clk = 0;
    always #5 clk = ~clk; // Periodo de 10 ns (100 MHz)

    // Configuración del testbench
    initial begin
        // Configuración para generar el archivo .vcd
        $dumpfile("PhaseCorrectPWM.vcd");  // Nombre del archivo VCD
        $dumpvars(0, PhaseCorrectPWM_tb);  // Niveles a registrar

        // Inicialización
        reset = 1;              // Activar el reset al inicio
        top = 32'd100;          // Valor máximo del contador
        pwm_a = 32'd50;         // Valor de comparación para salida A
        pwm_b = 32'd30;         // Valor de comparación para salida B
        #10 reset = 0;          // Desactivar el reset después de 10 ns

        // Simulación
        #500;  // Simular durante 500 ns

        // Finalizar simulación
        $stop;  // Detener la simulación
    end

endmodule
