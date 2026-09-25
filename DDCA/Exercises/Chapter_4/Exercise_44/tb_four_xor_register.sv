module tb_four_xor_register();
	integer vindx;
    localparam top=17;
	logic a, b, c, d;
	logic clk;
	logic y, y_exp;
	logic[4:0] vector_in[0 : top-1];
	four_xor_register dut(.a(a), .b(b), .c(c), .d(d), .clk(clk), .y(y));

	initial begin
		$readmemb("input_four_xor_register.txt", vector_in);
		$dumpfile("waveform_four_xor_register.vcd");
		$dumpvars(0, tb_four_xor_register);
		vindx = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{a, b, c, d, y_exp} = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (y !== y_exp) begin
			$display("Failed at line %d : input %b output %b", (vindx+1), {a, b, c, d}, y);
		end
		vindx++;
		if (vindx>=top) begin
			$display("Test finished");
			$finish;
		end
	end
endmodule
