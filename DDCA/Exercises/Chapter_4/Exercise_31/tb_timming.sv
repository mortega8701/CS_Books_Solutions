module tb_timming();
	integer vindx;
    localparam top=17;
	logic a, b, c, d;
	logic clk;
	logic x, x_exp, y, y_exp;
	logic[5:0] vector_in[0 : top-1];
	timming dut(.a(a), .b(b), .c(c), .d(d), .clk(clk), .x(x), .y(y));

	initial begin
		$readmemb("input_timming.txt", vector_in);
		$dumpfile("waveform_timming.vcd");
		$dumpvars(0, tb_timming);
		vindx = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{a, b, c, d, x_exp, y_exp} = vector_in[vindx]; #15;
	end

	always @(negedge clk) begin
		if (x !== x_exp || y !== y_exp) begin
			$display("Failed at line %d : input %b output %b", (vindx+1), {a, b, c, d}, {x, y});
		end
		vindx++;
		if (vindx>=top) begin
			$display("Test finished");
			$finish;
		end
	end
endmodule
