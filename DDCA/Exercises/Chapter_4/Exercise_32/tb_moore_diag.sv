module tb_moore_diag();
	integer vindx;
    localparam top=6;
	logic a, b;
	logic clk, reset;
	logic q, q_exp;
	logic[2:0] vector_in[0 : top-1];
	moore_diag dut(.a(a), .b(b), .clk(clk), .reset(reset), .q(q));

	initial begin
		$readmemb("input_moore_diag.txt", vector_in);
		$dumpfile("waveform_moore_diag.vcd");
		$dumpvars(0, tb_moore_diag);
		vindx = 0;
		reset = 1; #15; reset = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{a, b, q_exp} = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (~reset) begin
 			if (q !== q_exp) begin
				$display("Failed at line %d : input %b output %b", (vindx+1), {a, b}, q);
			end
			vindx++;
			if (vindx >= top) begin
				$display("Test finished");
				$finish;
			end
		end
	end
endmodule
