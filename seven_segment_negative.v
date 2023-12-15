module seven_segment_negative(i,ou);

input i;
output reg [6:0]ou; // a, b, c, d, e, f, g

/*
This combinational always block sets up a negative sign or zero on the seven
segment display based on an input from three_decimal_vals_w_neg
*/
always @(*)
begin
//case for negative
if (i) begin
ou[6] = 0;
ou[5] = 1;
ou[4] = 1;
ou[3] = 1;
ou[2] = 1;
ou[1] = 1;
ou[0] = 1;
end
//case for positive
else begin
ou[6] = 1;
ou[5] = 0;
ou[4] = 0;
ou[3] = 0;
ou[2] = 0;
ou[1] = 0;
ou[0] = 0;
end
end

endmodule