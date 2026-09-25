module tb_bubble_push1();
	localparam vindx = 32;
	logic a, b, c, d, e;
	logic y, y_exp;
	logic[5:0] vector_in[0 : vindx - 1];
	bubble_push1 dut(.a(a), .b(b), .c(c), .d(d), .e(e), .y(y));
	initial
	begin
		$readmemb("input_bubble_push1.txt", vector_in);
		$dumpfile("waveform_bubble_push1.vcd");
		$dumpvars(0, tb_bubble_push1);
		for (integer i=0; i < vindx; i++)
		begin
			{a, b, c, d, e, y_exp} = vector_in[i]; #10;
			assert (y === y_exp) else $error("Failed at line %d : input %b output %b", (i+1), {a, b, c, d, e}, y);
		end
	end
endmodule
