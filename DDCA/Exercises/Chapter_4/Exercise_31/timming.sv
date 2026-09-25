module timming 
	(input logic a, b, c, d,
	input logic clk,
	output logic x, y);

	logic a_reg, b_reg, c_reg, d_reg;
	logic n1, n2, n3;

	always_ff @(posedge(clk)) begin
		{a_reg, b_reg, c_reg, d_reg} <= {a, b, c, d};
		{x, y} <= {n2, n3};
	end

	assign n1 = (a_reg & b_reg); 
	assign n2 = (n1 | c_reg);
	assign n3 = ~(n2 | d_reg);
endmodule
