# Timer_PWM_Generator

## Descripción
Este proyecto implementa un generador de señales PWM con diferentes modos operativos (Normal, Fast PWM, Phase Correct). Utiliza OpenLane para síntesis y diseño físico.

### Funcionalidad
- **Entradas**: `clk`, `reset`, `TMR_SRC`, `TMR_MODE`, `TIMER_TOP`, `PWM_CNTA`, `PWM_CNTB`.
- **Salidas**: `PWM_OUTA`, `PWM_OUTB`, `timer_interrupt`.

### Submódulos
1. **Timer_NormalMode**: Modo de temporización estándar.
2. **Fast_PWM**: Generación de PWM rápida.
3. **PhaseCorrectPWM**: PWM con corrección de fase.

### Configuración para OpenLane
- Configuración definida en `config.json`.
- Archivo de restricciones: `Timer_PWM_Generator.sdc`.

### Simulación
El testbench (`Timer_PWM_Generator_tb.v`) genera un archivo de ondas (`Total.vcd`) para análisis.
