module delay(clk, rst, en, done);
input clk;
input rst;
input en;
output reg done;

parameter one_second = 26'd50000000;

reg [25:0]counter;

always @ (posedge clk or negedge rst)
	begin 
	if (rst == 1'b0)
	begin
		counter <= 26'd0;
		done <= 1'b0;
	end
	else
		if (en == 1'b1)
			if (counter <= one_second)
			begin
				done <= 1'b0;
				counter <= counter +1'b1;
			end
			else
			begin
				done <= 1'b1;
				counter <= 26'd0;
			end
	end
endmodule