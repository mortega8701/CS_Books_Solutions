module tb_sr_latch();
	localparam vindx = 7;
	logic s, r;
	logic q, q_exp, nq, nq_exp;
	logic[3:0] vector_in[0 : vindx - 1];
	sr_latch dut(.s(s), .r(r), .q(q), .nq(nq));
	initial
	begin
		$readmemb("input_sr_latch.txt", vector_in);
		$dumpfile("waveform_sr_latch.vcd");
		$dumpvars(0, tb_sr_latch);
		for (integer i=0; i < vindx; i++)
		begin
			{s, r, q_exp, nq_exp} = vector_in[i]; #10;
			assert (q === q_exp && nq === nq_exp) else $error("Failed at line %d : input %b output %b", (i+1), {s, r}, {q, nq});
		end
	end
endmodule
