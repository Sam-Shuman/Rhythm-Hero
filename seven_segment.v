module seven_segment (
input [3:0]i,
output reg [6:0]o
);


// HEX out - rewire DE2
//  ---a---
// |       |
// f       b
// |       |
//  ---g---
// |       |
// e       c
// |       |
//  ---d---

/*
This combinational always block sets up outputs to properly display a number on a seven segment display based on a 4 bit input
*/
always @(*)
begin
   o[0] = !((!i[2] & !i[0]) | (i[3]& !i[1] & !i[0]) | (i[3] & !i[2] & !i[1]) | (!i[3] & i[2] & i[0]) | (i[2] & i[1]) | (!i[3] & i[1]));
	o[1] = !((!i[2] & !i[0]) | (!i[3] & !i[2]) | (!i[3] & !i[1] & !i[0]) | (i[3] & !i[1] & i[0]) | (!i[3] & i[1] & i[0]));
	o[2] = !((!i[3] & !i[1]) | (!i[3] & i[0]) | (!i[3] & i[2] ) | (!i[1] & i[0]) | (i[3] & !i[2]));
	o[3] = !((!i[3] & !i[2] & !i[0] & !i[1]) | (!i[3] & !i[2] & i[1]) | (i[2] & i[1] & !i[0]) | ( i[2] & !i[1] & i[0]) | (i[3] & !i[2] & i[0]) | (i[3] & !i[1]));
	o[4] = !((!i[2] & !i[0]) | (i[1] & !i[0]) | (!i[1] & i[2] & i[3]) | (i[1] & i[0] & i[3]));
	o[5] = !((!i[1] & !i[0]) | (i[3] & !i[2]) | (!i[1] & !i[3] & i[2]) | (i[3] & i[2] & i[1]) | (i[2] & i[1] & !i[0]));
	o[6] = !((i[1] & !i[0]) | (i[3] & !i[2]) | (!i[1] & !i[3] & i[2]) | (i[0] & i[3] & i[2]) | (!i[3] & !i[2] & i[1]));
end

endmodule