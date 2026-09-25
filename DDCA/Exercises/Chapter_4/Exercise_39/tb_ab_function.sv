module tb_ab_function();
	integer vindx;
    localparam top=8;
	logic a, b;
	logic clk, reset;
	logic z, z_exp;
	logic[2:0] vector_in[0 : top-1];
	ab_function dut(.a(a), .b(b), .clk(clk), .reset(reset), .z(z));

	initial begin
		$readmemb("input_ab_function.txt", vector_in);
		$dumpfile("waveform_ab_function.vcd");
		$dumpvars(0, tb_ab_function);
		vindx = 0;
		reset = 1; #15; reset = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(negedge clk) begin
		{a, b, z_exp} = vector_in[vindx];
	end

	always @(posedge clk) begin
		if (~reset) begin
 			if (z !== z_exp) begin
				$display("Failed at line %d : input %b output %b", (vindx+1), {a, b}, z);
			end
			vindx++;
			if (vindx>=top) begin
				$display("Test finished");
				$finish;
			end
		end
	end
endmodule
