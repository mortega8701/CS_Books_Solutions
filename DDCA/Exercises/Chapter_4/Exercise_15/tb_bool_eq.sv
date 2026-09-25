module tb_bool_eq();
	localparam vindx = 16;
	logic a, b, c, d;
	logic y2, y1, y0, y2_exp, y1_exp, y0_exp;
	logic[6:0] vector_in[0 : vindx - 1];
	bool_eq dut(.a(a), .b(b), .c(c), .d(d), .y2(y2), .y1(y1), .y0(y0));
	initial
	begin
		$readmemb("input_bool_eq.txt", vector_in);
		$dumpfile("waveform_bool_eq.vcd");
		$dumpvars(0, tb_bool_eq);
		for (integer i=0; i < vindx; i++)
		begin
			{a, b, c, d, y2_exp, y1_exp, y0_exp} = vector_in[i]; #10;
			assert (y2 === y2_exp) else $error("Failed at line %d : input %b output y2 = %b", (i+1), {a, b, c, d}, y2);
			assert (y1 === y1_exp) else $error("Failed at line %d : input %b output y1 = %b", (i+1), {a, b, c, d}, y1);
			assert (y0 === y0_exp) else $error("Failed at line %d : input %b output y0 = %b", (i+1), {a, b, c, d}, y0);
		end
	end
endmodule
