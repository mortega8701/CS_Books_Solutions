module tb_prime_division();
	localparam vindx = 16;
	logic[3:0] a;
	logic p, p_exp, d, d_exp;
	logic[5:0] vector_in[0 : vindx - 1];
	prime_division dut(.a(a), .p(p), .d(d));
	initial
	begin
		$readmemb("input_prime_division.txt", vector_in);
		$dumpfile("waveform_prime_division.vcd");
		$dumpvars(0, tb_prime_division);
		for (integer i=0; i < vindx; i++)
		begin
			{a, p_exp, d_exp} = vector_in[i]; #10;
			assert (p === p_exp) else $error("Failed at line %d : input %b output p=%b", (i+1), a, p);
			assert (d === d_exp) else $error("Failed at line %d : input %b output d=%b", (i+1), a, d);
		end
	end
endmodule
