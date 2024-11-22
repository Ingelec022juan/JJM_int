create_clock -period 10 [get_ports clk]
set_input_delay 2 [get_ports reset]
set_output_delay 2 [get_ports {PWM_OUTA PWM_OUTB timer_interrupt}]
