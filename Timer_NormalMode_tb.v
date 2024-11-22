`timescale 1ns / 1ps

module Timer_NormalMode_tb;

    // Entradas
    reg clk;
    reg reset;

    // Salidas
    wire irq_timer;
    wire [31:0] timer_cnt;

    // Instancia del módulo a probar
    Timer_NormalMode uut (
        .clk(clk),
        .reset(reset),
        .irq_timer(irq_timer),
        .timer_cnt(timer_cnt)
    );

    // Generación del reloj
    initial clk = 0;
    always #5 clk = ~clk; // Periodo de 10 ns

    // Configuración del testbench
    initial begin
        // Configuración para generar el archivo .vcd
        $dumpfile("Timer_NormalMode.vcd");  // Nombre del archivo VCD
        $dumpvars(0, Timer_NormalMode_tb);  // Niveles a registrar

        // Inicialización
        reset = 1; // Activar el reset al inicio
        #10 reset = 0; // Desactivar el reset después de 10 ns

        // Simulación
        #100;  // Simular durante 100 ns

        // Finalizar simulación
        $stop; // Detener la simulación

    end

endmodule
