module Timer_PWM_Generator_tb;

    // Declaración de señales para conectar al DUT (Device Under Test)
    reg clk;                         // Reloj principal
    reg reset;                       // Señal de reinicio
    reg [1:0] TMR_SRC;               // Fuente del temporizador
    reg [1:0] TMR_MODE;              // Modo del temporizador
    reg [31:0] TIMER_TOP;            // Valor máximo del temporizador
    reg [31:0] PWM_CNTA;             // Valor de comparación para salida A
    reg [31:0] PWM_CNTB;             // Valor de comparación para salida B
    wire PWM_OUTA;                   // Salida PWM A
    wire PWM_OUTB;                   // Salida PWM B
    wire timer_interrupt;            // Señal de interrupción

    // Instanciación del módulo bajo prueba (DUT)
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

    // Generación de reloj (50 MHz, periodo de 20 unidades de tiempo)
    always #10 clk = ~clk;

    // Bloque inicial para la simulación
    initial begin
        // Inicialización de señales
        clk = 0;
        reset = 1;
        TMR_SRC = 2'b01;             // Usar reloj interno como fuente
        TMR_MODE = 2'b00;            // Modo Normal
        TIMER_TOP = 32'h0000_00FF;   // Valor máximo del temporizador (fijo)
        PWM_CNTA = 32'h0000_0050;    // Valor de comparación para PWM_OUTA (fijo)
        PWM_CNTB = 32'h0000_00A0;    // Valor de comparación para PWM_OUTB (fijo)

        // Asynchronous reset (reset asíncrono)
        #20 reset = 0;               // Desactiva reset después de 20 unidades de tiempo
        #15 reset = 1;               // Activa reset brevemente de forma asíncrona
        #10 reset = 0;               // Desactiva nuevamente reset
    end

    // Pruebas en diferentes modos
    initial begin
        // Espera tras reset inicial
        #50;

        // Prueba del Modo Normal
        TMR_MODE = 2'b00;            // Modo Normal
        #500;
        $display("Probando el Modo Normal...");

        // Cambiar a Modo Fast PWM
        TMR_MODE = 2'b01;            // Modo Fast PWM
        #500;
        $display("Probando el Modo Fast PWM...");

        // Cambiar a Modo Phase Correct PWM
        TMR_MODE = 2'b10;            // Modo Phase Correct PWM
        #1000;
        $display("Probando el Modo Phase Correct PWM...");

        // Finalizar simulación
        $finish;
    end

    // Bloque para generar archivo VCD para visualización de ondas
    initial begin
        $dumpfile("general.vcd");
        $dumpvars(0, Timer_PWM_Generator_tb);
    end

endmodule

