module tb_reverse_eng2();
	integer vindx;
    localparam top=7;
	logic a;
	logic clk, reset;
	logic q, q_exp;
	logic[1:0] vector_in[0 : top-1];
	reverse_eng2 dut(.a(a), .clk(clk), .reset(reset), .q(q));

	initial begin
		$readmemb("input_reverse_eng2.txt", vector_in);
		$dumpfile("waveform_reverse_eng2.vcd");
		$dumpvars(0, tb_reverse_eng2);
		vindx = 0;
		reset = 1; #15; reset = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{a, q_exp} = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (~reset) begin
 			if (q !== q_exp) begin
				$display("Failed at line %d : input %b output %b", (vindx+1), a, q);
			end
			vindx++;
			if (vindx>=top) begin
				$display("Test finished");
				$finish;
			end
		end
	end
endmodule
