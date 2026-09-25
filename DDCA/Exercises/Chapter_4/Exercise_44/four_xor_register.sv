module four_xor_register
	(input logic a, b, c, d,
	input logic clk,
	output logic y);

	logic reg_a, reg_b, reg_c, reg_d;
	logic n1, n2, n3;

	always_ff @(posedge(clk)) begin
		{reg_a, reg_b, reg_c, reg_d} <= {a, b, c, d};
		y <= n3;
	end

	assign n1 = (reg_a ^ reg_b); 
	assign n2 = (n1 ^ reg_c);
	assign n3 = (n2 ^ reg_d);
endmodule
