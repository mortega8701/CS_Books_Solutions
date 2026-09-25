module bubble_push2
	(input logic a, b, c, d, e, f, g, 
	output logic y);

	always_comb begin
		y = ~& (~(~(~(a & b & c) & d) | ~(e | (f & g))));
	end
endmodule
