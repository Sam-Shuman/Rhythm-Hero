module guitar(
input clk,
input rst,
input start,
input [3:0]buttons,
output [6:0]seg7_neg_sign,
output [6:0]seg7_dig0,
output [6:0]seg7_dig1,
output [6:0]seg7_dig2,
output [6:0]num_to_hit,
output reg led
);

reg [2:0]S;
reg [2:0]NS;

wire [15:0] randwire;
reg [6:0]song_dur;
reg [6:0]notes_played;
reg [15:0]random;
reg [3:0]hit_num;
reg [3:0]button_hold;
reg [7:0]score;
reg en;
reg en2;
wire deldone;
wire deldone2;
reg del_hold;
reg del_hold2;
reg randhelp;
parameter START = 3'd0,
			 CHECK = 3'd1,
			 NOTE = 3'd2,
			 DELAY = 3'd3,
			 DONE = 3'd4;
			 
rand_gen myrand(clk, rst, 16'd122112112121, randhelp, randwire);

seven_segment numout(hit_num, num_to_hit);

three_decimal_vals_w_neg mynum(score, seg7_neg_sign, seg7_dig0, seg7_dig2, seg7_dig1);

time_to_hit my(clk, rst, en, deldone);	
		 
delay mydelay(clk, rst, en2, deldone2);			 
always @(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
	begin
		S <= START;
	end
	else
	begin
		S <= NS;
	end
end

always @(*) 
begin
	case (S)
		START:
		begin
		if (start == 1'b1)
						NS = CHECK;
				 else
						NS = START;
		end
		CHECK:
		begin
		
		if (notes_played <= song_dur)
						NS = NOTE;
	   else
						NS = DONE;
		end
		NOTE: 
		begin
		if (del_hold == 1'b1)
					NS = DELAY;
				 else 
					NS = NOTE;
		end
		DELAY: 
		begin
		if (del_hold2 == 1'b1)
					NS = CHECK;
				 else 
					NS = DELAY;
		end
		
		DONE: NS = DONE;
		default NS = START;
	endcase
end

always @(posedge clk or negedge rst)
begin
	if(rst == 1'b0)
	begin
		notes_played <= 7'd0;
		song_dur <= 7'd127;
		led <= 1'b0;
		score <= 8'd0;
		randhelp <= 1'b0;
		del_hold <= 1'b0;
		del_hold2 <= 1'b0;
		
	end
	else
	begin
		case (S)
			CHECK:
			begin
				hit_num <= random % 4;
				song_dur <= 7'd127;
				random <= randwire;
				randhelp <= 1'b1;
				del_hold <= 1'b0;
				del_hold2 <= 1'b0;
				en <= 1'b0;
				en2 <= 1'b0;
				button_hold[0] <= 1'b0;
				button_hold[1] <= 1'b0;
				button_hold[2] <= 1'b0;
				button_hold[3] <= 1'b0;
			end
			NOTE:
			begin
			   notes_played <= notes_played + 1;
			 	en <= 1'b1;
				del_hold <= deldone;
				button_hold[0] <= !buttons[0];
				button_hold[1] <= !buttons[1];
				button_hold[2] <= !buttons[2];
				button_hold[3] <= !buttons[3];
				if (hit_num == 4'd0)
					if (button_hold[0] == 1'b1)
					begin
						score <= score + 1'b1;
						del_hold <= 1;
					end
				    else if (button_hold[1] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					end
					else if (button_hold[2] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					end
					else if (button_hold[3] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					end
				if (hit_num == 4'd1)
					if (button_hold[1] == 1'b1)
						begin
						score <= score + 1'b1;
						del_hold <= 1;
					end
					else if (button_hold[0] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					end
					else if (button_hold[2] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					end
					else if (button_hold[3] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					end
				if (hit_num == 4'd2)
					if (button_hold[2] == 1'b1)
						begin
						score <= score + 1'b1;
						del_hold <= 1;
					end
					else if (button_hold[1] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					end
					else if (button_hold[0] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					end
					else if (button_hold[3] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					end
				if (hit_num == 4'd3)
					if (button_hold[3] == 1'b1)
						begin
						score <= score + 1'b1;
						del_hold <= 1;
					end
					else if (button_hold[1] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					 end
					else if (button_hold[2] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					 end
					else if (button_hold[0] == 1'b1)
						begin
						score <= score - 1'b1;
						del_hold <= 1;
					 end
				
				
				
			end
			
			DELAY: 
			begin
			en2 <= 1'b1;
			del_hold2 <= deldone2;
			
			end
			DONE: led <= 1'b1;
		endcase
	end
end

endmodule