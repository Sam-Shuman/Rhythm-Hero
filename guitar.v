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

wire [15:0]randwire;
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
			 
//instantiates the linear feedback shift register with a random number, sets up for the "random" 
//reg which is used for the number to hit 
rand_gen myrand(clk, rst, 16'd122112112121, randhelp, randwire);

//instantiates the seven segment display for the number to hit
seven_segment numout(hit_num, num_to_hit);

//instansiatess the display for the 3 score values as well as the negative sign 
three_decimal_vals_w_neg mynum(score, seg7_neg_sign, seg7_dig0, seg7_dig2, seg7_dig1);

//instantiates a delay module which is used to give the user time to hit the buttons
time_to_hit my(clk, rst, en, deldone);			 

//instantiates a delay module for after the user hits a number
delay mydelay(clk, rst, en2, deldone2);			

/*
This sequential always block sets up how the code changes states, initially starting at Start
and then when reset is off, the current state or S is set to next state or NS.


*/
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

/*
This combinational always block sets up the conditional for each of the states to move to the
next state in the code.

*/
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
		//Checks the value of notes_played and as long as it is less than or equal to the song 
		//duration the next state will be note and if notes_played is less than the song duration
		//then the next state is the done state which ends the code
		CHECK:
		begin
		
		if (notes_played <= song_dur)
						NS = NOTE;
	   else
						NS = DONE;
		end
		
		//The NOTE state is left open until del_hold(the output from the time_to_hit delay module)
		//is turned on or if the user hits a button during this state		
		NOTE: 
		begin
		if (del_hold == 1'b1)
					NS = DELAY;
				 else 
					NS = NOTE;
		end
		//This state begins right after NOTE and loops until the delay module feeds the delay done
		//signal back through sending the state back to CHECK
		DELAY: 
		begin
		if (del_hold2 == 1'b1)
					NS = CHECK;
				 else 
					NS = DELAY;
		end
		
		//loops infinately as the code is finished
		DONE: NS = DONE;
		
		//if the code breaks the default state is START
		default NS = START;
	endcase
end

/*
This sequential always block sets up what happens during each of the states and holds the main
functions of the project.
*/
always @(posedge clk or negedge rst)
begin
   // sets most values equal to zero except song_dur which is the duration that the code runs for,
   // in this case 127 cycles through the finite state machine
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
		   // CHECK performs the calculation for the number that the user needs to hit which
			// is the random number mod 4 giving a value between 0-3.
			CHECK:
			begin
				hit_num <= random % 4;
				song_dur <= 7'd127;
				// sets random to the output of the rand_gen module
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
			//NOTE performs the main function of the code, where if the hit_num is 0-3, the button
			//that needs to be pressed 0-3 has to be the button hit to increase score by 2 otherwise
			//score is subtracted by 2, also increases the notes_played value by 1(cycles through FSM)
			//it also sets up del_hold to the ouput from time_to_hit deldone as well as sets the 
			//value of del_hold to 1 if a button is pressed
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
						score <= score + 2'd2;
						del_hold <= 1;
					end
				    else if (button_hold[1] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					end
					else if (button_hold[2] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					end
					else if (button_hold[3] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					end
				if (hit_num == 4'd1)
					if (button_hold[1] == 1'b1)
						begin
						score <= score + 2'd2;
						del_hold <= 1;
					end
					else if (button_hold[0] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					end
					else if (button_hold[2] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					end
					else if (button_hold[3] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					end
				if (hit_num == 4'd2)
					if (button_hold[2] == 1'b1)
						begin
						score <= score + 2'd2;
						del_hold <= 1;
					end
					else if (button_hold[1] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					end
					else if (button_hold[0] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					end
					else if (button_hold[3] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					end
				if (hit_num == 4'd3)
					if (button_hold[3] == 1'b1)
						begin
						score <= score + 2'd2;
						del_hold <= 1;
					end
					else if (button_hold[1] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					 end
					else if (button_hold[2] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					 end
					else if (button_hold[0] == 1'b1)
						begin
						score <= score - 2'd2;
						del_hold <= 1;
					 end
				
				
				
			end
			
			//Delay just starts the delay module and waits from 
			DELAY: 
			begin
			en2 <= 1'b1;
			del_hold2 <= deldone2;
			
			//sets an led to on to show that the program is finished
			end
			DONE: led <= 1'b1;
		endcase
	end
end

endmodule