module tb_bubble_push2();
	localparam vindx = 128;
	logic a, b, c, d, e, f, g;
	logic y, y_exp;
	logic[7:0] vector_in[0 : vindx - 1];
	bubble_push2 dut(.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .y(y));
	initial
	begin
		$readmemb("input_bubble_push2.txt", vector_in);
		$dumpfile("waveform_bubble_push2.vcd");
		$dumpvars(0, tb_bubble_push2);
		for (integer i=0; i < vindx; i++)
		begin
			{a, b, c, d, e, f, g, y_exp} = vector_in[i]; #10;
			assert (y === y_exp) else $error("Failed at line %d : input %b output %b", (i+1), {a, b, c, d, e, f, g}, y);
		end
	end
endmodule
