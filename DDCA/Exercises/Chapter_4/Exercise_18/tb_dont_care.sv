module tb_dont_care();
	localparam vindx = 16;
	logic a, b, c, d;
	logic y, y_exp;
	logic[4:0] vector_in[0 : vindx - 1];
	dont_care dut(.a(a), .b(b), .c(c), .d(d), .y(y));
	initial
	begin
		$readmemb("input_dont_care.txt", vector_in);
		$dumpfile("waveform_dont_care.vcd");
		$dumpvars(0, tb_dont_care);
		for (integer i=0; i < vindx; i++)
		begin
			{a, b, c, d, y_exp} = vector_in[i]; #10;
			assert (y === y_exp) else $error("Failed at line %d : input %b output %b", (i+1), {a, b, c, d}, y);
		end
	end
endmodule
