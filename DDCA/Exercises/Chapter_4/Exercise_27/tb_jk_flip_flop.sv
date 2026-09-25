module tb_jk_flip_flop();
	localparam vindx = 8;
	logic j, k, clk;
	logic q, q_exp;
	logic[2:0] vector_in[0 : vindx - 1];
	jk_flip_flop dut(.j(j), .k(k), .clk(clk), .q(q));
	initial
	begin
		$readmemb("input_jk_flip_flop.txt", vector_in);
		$dumpfile("waveform_jk_flip_flop.vcd");
		$dumpvars(0, tb_jk_flip_flop);
		clk = 1'b0; #5;
		for (integer i=0; i < vindx; i++)
		begin
			clk = ~clk;
			{j, k, q_exp} = vector_in[i]; #10;
			assert (q === q_exp) else $error("Failed at line %d : input %b output %b", (i+1), {j, k}, q);
		end
	end
endmodule
