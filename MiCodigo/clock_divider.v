module clock_divider 
#(parameter INIT=0)
(
  input clk,//clk pin23
  input sw_on,//	pin34  ---on ==0
  input gases,// pin 32 
  input movimiento,// pin42
  input clave,// pin 38
  output reg clk_out,//led pin74
  output reg sound=0,// pin 30
  output reg mensaje=0// pin 28
);

/* count = (clk_in / clk_out) */
/* Ejemplo 1 */
/* count = 25E6 = 25000000 = (25E6 Mhz)/(1 Hz) */
/* SIZE = 2^25 = 33.5E6 lo contiene */
/* Ejemplo 2 */
/* count = (50E6 Mhz)/(1 Hz) = 50E6 = 50000000 */
/* SIZE = 2^26 = 67.5E6 lo contiene */


parameter SIZE = 300; 
parameter LIMIT = 30'd833333;//600 hz/
parameter LIMIT_sound = 30'd833333;//600 hz/


parameter lim_gases=30'd250000000;
parameter lim_movimiento=30'd250000000;


reg reset=0;
reg s_gases=0;
reg s_movimiento=0;

reg [SIZE-1:0] count = INIT;
reg [SIZE-1:0] con_gases=0;
reg [SIZE-1:0] con_movimiento=0;
reg [SIZE-1:0] ceros=0;

always@(posedge clk)
begin
	
	//estado 0
	if(sw_on==1)
	begin 
		sound<=0;
		mensaje<=0;
		reset<=0;
		
		con_gases<=ceros;
		con_movimiento<=ceros;
	end
	
	//fin estado 0
	//logica on
	if(sw_on==0 & reset==0)
	begin
		//compardaor de 4 bits
		if(gases & ~movimiento)//caso 01----(gas-mov)
		begin
			con_movimiento<=con_movimiento+1;
		end
		else
		begin
			if(~gases & movimiento)//caso 10----(gas-mov)
			begin
				con_gases<=con_gases+1;
			end
			else
			begin
				if(~gases & ~movimiento)//caso 11----(gas-mov)
				begin
					con_movimiento<=con_movimiento+1;
					con_gases<=con_gases+1;
				end
				else
				begin
				 //caso 00 es posible poner en 0 todo aqui
				end
			end
		end
		//end comparador
		
//////////////////////////////////////////////////////////////////////////////////////////
		if ((con_gases>=lim_gases) | (con_movimiento>=lim_movimiento)) 
		begin
			if(con_gases>=lim_gases)//// (gases-)
			begin
				if(clave==1)
				begin
					//oscilador
					if(count == LIMIT)
					begin
						count <= 0;
						clk_out <= ~clk_out;
						sound<= ~sound;
					end
					else
					begin
						count <= count + 1;
					end
					// end oscilador
				end
				else
				begin
					reset<=1;
					sound<=0;
					mensaje<=0;
				end	
			end
			else				
			begin
			end
			
			if(con_movimiento>=lim_movimiento)//// (gases-)
			begin
				if(clave==1)
				begin
					mensaje<=1;
				end
				else
				begin
					reset<=1;
					sound<=0;
					mensaje<=0;
				end
				end
			else
			begin
			end
			
		end 
		else 
		begin
		end
	 
		
/////////////////////////////////////////////////////////////////////////////////////////////		
	end
	else
	begin
		//case 00
	end
	// end logica
end


					
endmodule
