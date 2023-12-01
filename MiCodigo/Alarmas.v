
module Alarmas
#(parameter INIT=0)
(
input clk,//clk pin23
  input sw_on,//	pin34  ---on ==0
  input gases,// pin 32 
  input movimiento,// pin42
  input clave,// pin 55
  output reg clk_out=0,//led pin74
  output reg sound=0,// pin 30
  output reg mensaje=0,// pin 28
  
  /*//intvitual top
  input [26:0] count,
  input [26:0] con_gases,
  input [26:0] con_movimiento
  */
);

parameter SIZE = 27; 
parameter LIMIT = 27'd833333;/*60 hz*/
parameter LIMIT_sound = 27'd833333;/*60 hz*/


parameter lim_gases=27'd100000000;
parameter lim_movimiento=27'd100000000;

reg [SIZE-1:0] count = INIT;
reg [SIZE-1:0] con_gases=0;
reg [SIZE-1:0] con_movimiento=0;

reg [SIZE-1:0] count2 = INIT;

always@(posedge clk)
begin

	if(sw_on==0)
	begin
			
	end
	begin
		sound<=0;
		mensaje<=0;
		clk_out <=0;
		
	end


end 

endmodule
