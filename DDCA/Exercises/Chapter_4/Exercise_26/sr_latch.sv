module sr_latch 
	(input logic s, r,
	output logic q, nq);

	assign nq = s ~| q;
	assign q = r ~| nq;
endmodule
