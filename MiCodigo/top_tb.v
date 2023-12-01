module tb_top;

  // Parámetros para el reloj
  reg clk;
  reg sw_on;
  reg gases;
  reg movimiento;
  reg clave;

  // Salidas del módulo
  wire led;
  wire sound;
  wire mensaje;

  // Instancia del módulo top
  top #(.INIT(0)) uut (
    .clk(clk),
    .sw_on(sw_on),
    .gases(gases),
    .movimiento(movimiento),
    .clave(clave),
    .led(led),
    .sound(sound),
    .mensaje(mensaje)
  );

  // Generador de reloj
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test case
  initial begin
    // Configuración inicial
    sw_on = 1;
    gases = 0;
    movimiento = 0;
    clave = 1;

    // Caso 1: Activar gases
    #10 gases = 1;

    // Caso 2: Movimiento detectado y clave desactivada
    #10 movimiento = 1;
    #10 clave = 0;

    // Caso 3: Cambiar clave y desactivar gases
    #10 clave = 1;
    #10 gases = 0;

    // Caso 4: Activar interruptor general
    #10 sw_on = 0;

    // Caso 5: Combinación de condiciones
    #10 sw_on = 1;
    #10 gases = 1;
    #10 movimiento = 1;
    #10 clave = 0;

    // Finalizar simulación después de algunas unidades de tiempo
    #100 $finish;
  end
  initial
  begin
    $dumpfile("top.vcd");
    $dumpvars(0, tb_top);
  end

endmodule
