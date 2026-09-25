module improved_latch
	(input logic d, clk,
	output logic q);

	logic n1, n2, nclk;

	assign  #5 n1 = clk & d;
	assign  #5 n2 = nclk & q;
	assign  #3 q = n1 | n2;
	assign  #1 nclk = ~clk;
endmodule
