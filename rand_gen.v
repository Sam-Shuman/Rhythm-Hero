module rand_gen(clk, rst, srand, init_srand, randi);
input clk;
input rst;
input [15:0]srand;
input init_srand;
output reg [15:0]randi;

always @(posedge clk or negedge rst)
begin
	if(rst == 1'b0)
		randi <= 16'd0;
	else
		if(init_srand == 1'b0)
			randi <= srand;
		else
			randi <= {randi[13] ^ randi[0], randi[14] ^ randi[15], randi[13:8], (randi[7] ^ randi[2] ^ randi[1]), randi[5:0], randi[6] ^ randi[7]};
end
endmodule