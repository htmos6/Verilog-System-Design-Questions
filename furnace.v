module furnace(clock, door_sig, usage, furnace_temp, alarm);

input clock;
input door_sig, usage;
output reg [6:0] furnace_temp;
output reg alarm;

initial begin
	furnace_temp <= 7'd50;
	alarm <= 1'b0;
end


always @(negedge clock) begin
	
	if (door_sig == 1'b0 && furnace_temp < 7'd120 && usage == 1'b0) begin 
		alarm <= 1'b0;
		if (furnace_temp + 7'd5 > 7'd120) begin
			furnace_temp <= 7'd120;
		end
		else begin
			furnace_temp <= furnace_temp + 7'd5;
		end
	end
	
	else if (door_sig == 1'b1 && usage == 1'b0 ) begin
		alarm <= 1'b1;
		
		if (furnace_temp-7'd2 > 7'd25) begin
			furnace_temp <= furnace_temp - 7'd2;
		end
		else begin
			furnace_temp <= 7'd25;
		end
	end
	
	else if ( door_sig == 1'b1 && usage == 1'b1) begin 
		
			if (furnace_temp-7'd2 > 7'd25) begin
				furnace_temp <= furnace_temp - 7'd2;
				alarm <= 1'b0;
			end
			else begin
				furnace_temp <= 7'd25;
				alarm <= 1'b1;
			end
	end
	
	else if (door_sig == 1'b0 && usage == 1'b0 ) begin
		alarm <= 1'b0;
	end
	
end

endmodule
