module bubble_push1
	(input logic a, b, c, d, e,
	output logic y);

	always_comb begin
		y = ((a ~& b) ~& (c ~& d)) ~& e;
	end
endmodule
