`timescale 1ns / 1ps

module Timer_PWM_Generator_tb;

    // Entradas
    reg clk;
    reg reset;
    reg [1:0] TMR_SRC;
    reg [1:0] TMR_MODE;
    reg [31:0] TIMER_TOP;
    reg [31:0] PWM_CNTA;
    reg [31:0] PWM_CNTB;

    // Salidas
    wire PWM_OUTA;
    wire PWM_OUTB;
    wire timer_interrupt;

    // Instancia del módulo a probar
    Timer_PWM_Generator uut (
        .clk(clk),
        .reset(reset),
        .TMR_SRC(TMR_SRC),
        .TMR_MODE(TMR_MODE),
        .TIMER_TOP(TIMER_TOP),
        .PWM_CNTA(PWM_CNTA),
        .PWM_CNTB(PWM_CNTB),
        .PWM_OUTA(PWM_OUTA),
        .PWM_OUTB(PWM_OUTB),
        .timer_interrupt(timer_interrupt)
    );

    // Generación del reloj
    initial clk = 0;
    always #5 clk = ~clk; // Periodo de 10 ns

    initial begin
        // Configuración para generar el archivo .vcd
        $dumpfile("Total.vcd"); // Nombre del archivo
        $dumpvars(0, Timer_PWM_Generator_tb); // Niveles a registrar: 0 significa todas las señales

        // Inicialización
        reset = 1;
        TMR_SRC = 2'b00; // Fuente deshabilitada
        TMR_MODE = 2'b00; // Modo Normal
        TIMER_TOP = 32'd100; // Valor máximo
        PWM_CNTA = 32'd50;  // Comparador A
        PWM_CNTB = 32'd25;  // Comparador B
        #20 reset = 0; // Quitar el reset después de 20 ns

        // Prueba en modo Normal
        TMR_MODE = 2'b00;
        TMR_SRC = 2'b01; // Activar fuente del reloj
        #200;

        // Prueba en modo Fast PWM
        TMR_MODE = 2'b01;
        #200;

        // Prueba en modo Phase Correct PWM
        TMR_MODE = 2'b10;
        #200;

        // Deshabilitar el temporizador
        TMR_SRC = 2'b00;
        TMR_MODE = 2'b00;
        #100;

        // Finalizar simulación
        $stop;
    end

endmodule
