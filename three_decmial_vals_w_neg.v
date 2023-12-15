module three_decimal_vals_w_neg (
input [7:0]val,

output [6:0]seg7_neg_sign,
output [6:0]seg7_lsb,
output [6:0]seg7_mmb,
output [6:0]seg7_msb
);

reg [3:0] result_hun_digit;
reg [3:0] result_one_digit;
reg [3:0] result_ten_digit;
reg result_is_negative;

reg [6:0]twos_comp;
 
always @(*)

begin
result_is_negative = 1'b0;
twos_comp = 1'b0;

	if(val[7] == 1'b1) begin
	result_is_negative = 1'b1;

	if(val[0] == 1'b1) begin
		twos_comp[0] = val[0];
		twos_comp[1] = !val[1];
		twos_comp[2] = !val[2];
		twos_comp[3] = !val[3];
		twos_comp[4] = !val[4];
		twos_comp[5] = !val[5];
		twos_comp[6] = !val[6];
		end
	else if(val[1] == 1'b1) begin
		twos_comp[0] = val[0];
		twos_comp[1] = val[1];
		twos_comp[2] = !val[2];
		twos_comp[3] = !val[3];
		twos_comp[4] = !val[4];
		twos_comp[5] = !val[5];
		twos_comp[6] = !val[6];
		end
	else if(val[2] == 1'b1) begin
		twos_comp[0] = val[0];
		twos_comp[1] = val[1];
		twos_comp[2] = val[2];
		twos_comp[3] = !val[3];
		twos_comp[4] = !val[4];
		twos_comp[5] = !val[5];
		twos_comp[6] = !val[6];
		end
	else if(val[3] == 1'b1) begin
		twos_comp[0] = val[0];
		twos_comp[1] = val[1];
		twos_comp[2] = val[2];
		twos_comp[3] = val[3];
		twos_comp[4] = !val[4];
		twos_comp[5] = !val[5];
		twos_comp[6] = !val[6];
		end
	else if(val[4] == 1'b1) begin
		twos_comp[0] = val[0];
		twos_comp[1] = val[1];
		twos_comp[2] = val[2];
		twos_comp[3] = val[3];
		twos_comp[4] = val[4];
		twos_comp[5] = !val[5];
		twos_comp[6] = !val[6];
		end
	else if(val[5] == 1'b1) begin
		twos_comp[0] = val[0];
		twos_comp[1] = val[1];
		twos_comp[2] = val[2];
		twos_comp[3] = val[3];
		twos_comp[4] = val[4];
		twos_comp[5] = val[5];
		twos_comp[6] = !val[6];
	
		
	end
	end
	
	if(val[7] == 1'b0) begin
		
	result_one_digit = val % 10;
			
	result_ten_digit = (val / 10) % 10;
	result_hun_digit = val / 100;
	result_is_negative = 0;
	end
	else begin
	result_one_digit = twos_comp % 10;
	result_ten_digit = (twos_comp / 10) % 10;
	result_hun_digit = twos_comp / 100;
	end
end
/* convert the binary value into 3 signals */


/* instantiate the modules for each of the seven seg decoders including the negative one */
seven_segment msb(result_ten_digit, seg7_msb);
seven_segment lsb(result_one_digit, seg7_lsb);
seven_segment mmb(result_hun_digit, seg7_mmb);
seven_segment_negative neg(result_is_negative, seg7_neg_sign);

endmodule