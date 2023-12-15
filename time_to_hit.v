module time_to_hit(clk, rst, en, done);
input clk;
input rst;
input en;
output reg done;

//sets a parameter for how long a second is which is based on the 
//clock for this project which is 50 million hz
parameter one_second = 26'd50000000;

reg [25:0]counter;

/*
This seqential always block sets the value of counter to 0 until reset 
is on in which counter counts each clock cycle, adding 1 to the counter
until it reaches the parameter, sending a done signal to guitar. In this
case though the done signal can also be activated by a button press in
the guitar file.
*/
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