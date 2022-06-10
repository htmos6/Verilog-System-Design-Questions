module car_gear_speed_control(clock, gas, carbreak, speed, gear);
	// define input and output parameters
	input clock, gas, carbreak;
	output reg [1:0] gear;
	output reg [6:0] speed;
	
	// initially set corresponding values --> speed as 0 and gear as 1
	initial begin
		speed <= 7'd0;
		gear <= 2'd1;
	end
	
	// every positive clock edge 
	always @(posedge clock) begin
	
		if (gear == 2'd1) begin
			if (speed < 7'd40) begin
				case ({gas,carbreak})
					2'b10: begin
						speed <= speed + 7'd5;
					end
					2'b01: begin
						if(speed == 7'd2) begin
							speed <= speed - 7'd3;
						end
						else begin
							speed <= 7'd0;
						end
					end
					default: speed <= speed;
				endcase
			end
			else if (speed > 7'd39) begin 
				gear <= 2'd2;
			end
			
		end
		else if (gear == 2'd2) begin
			if (speed > 7'd59) begin
				gear <= 2'd3;
			end
			else if (speed < 7'd27) begin 
				gear <= 2'd1;
			end 
			else begin 
				case({gas,carbreak})
					2'b10: begin
						speed <= speed + 7'd3;
					end
					2'b01: begin
						speed <= speed - 7'd2;
					end
					2'b11: begin
						speed <= speed - 7'd1;
					end
					default: speed <= speed;
				endcase
			end
		end
		else if (gear == 2'd3) begin
			if (speed < 7'd55) begin 
				gear <= 2'd2;
			end 
			else begin
				case({gas,carbreak}) 
					2'b10: begin
						if(speed < 7'd79) begin 
							speed <= speed + 7'd2;	
						end
						else begin 
							speed <= 7'd80;	
						end
					end
					2'b01: begin
						speed <= speed - 7'd1;
					end
					default:speed <= speed;
				endcase			
			end
		end
	end
endmodule
