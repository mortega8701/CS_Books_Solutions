module bool_eq
	(input logic a, b, c, d,
	output logic y2, y1, y0);

	always_comb begin
		y2 = (a & c) | (~a & ~b & c);
		y1 = (~a & ~b) | (~a & b & ~c) | ~(a | ~c);
		y0 = (~a & ~b & ~c & ~d) | (a & ~b & ~c) | (a & ~b & c & ~d) | (a & b & d) |(~a & ~b & c & ~d) | (b & ~c & d) | ~a;
	end
endmodule
