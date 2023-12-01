
module top 
#(parameter INIT=0)
(
  // 25MHz clock input
  input  clk, //pin 23
  input  sw_on,//pin 34
  input  gases,//pin 32
  input  movimiento,//pin42
  input  clave,//pin55
  // Led outputs
  /* output [3:0] led */
  output led,//pin 74
  output sound, //pin 30
  output mensaje//pin 28
);

  // turn other leds off (active low)
  /* assign led[2:0] = 3'b111; */
	/*wire [26:0] cable_count;
	wire [26:0] cable_con_gases;
	wire [26:0] cable_con_movimiento;
	*/
  clock_divider #(.INIT(INIT)) div
  (
    .clk(clk),
    .sw_on(sw_on),
    .gases(gases),
    .movimiento(~movimiento),
    .clave(clave),
    .clk_out(led),
    .sound(sound),
    .mensaje(mensaje)
  );
  
  
  
  
endmodule
