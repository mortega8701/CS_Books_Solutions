module tb_improved_latch();
	localparam vindx = 8;
	logic d, clk;
	logic q, q_exp;
	logic[2:0] vector_in[0 : vindx - 1];
	improved_latch dut(.d(d), .clk(clk), .q(q));
	initial
	begin
		$readmemb("input_improved_latch.txt", vector_in);
		$dumpfile("waveform_improved_latch.vcd");
		$dumpvars(0, tb_improved_latch);
		for (integer i=0; i < vindx; i++)
		begin
			{d, clk, q_exp} = vector_in[i]; #20;
			assert (q === q_exp) else $error("Failed at line %d : input %b output %b", (i+1), {d, clk}, q);
		end
        $finish;
	end
endmodule
