module tb_improved_lights();
	integer vindx;
    localparam top=9;
	logic ta, tb;
	logic clk, reset;
	logic[1:0] la, la_exp, lb, lb_exp;
	logic[5:0] vector_in[0 : top-1];
	improved_lights dut(.ta(ta), .tb(tb), .clk(clk), .reset(reset), .la(la), .lb(lb));

	initial begin
		$readmemb("input_improved_lights.txt", vector_in);
		$dumpfile("waveform_improved_lights.vcd");
		$dumpvars(0, tb_improved_lights);
		vindx = 0;
		reset = 1; #15; reset = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{ta, tb, la_exp, lb_exp} = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (~reset) begin
 			if (la !== la_exp || lb !== lb_exp) begin
				$display("Failed at line %d : input %b output %b", (vindx+1), {ta, tb}, {la, lb});
			end
			vindx++;
			if (vindx>=top) begin
				$display("Test finished");
				$finish;
			end
		end
	end
endmodule
