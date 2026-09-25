module tb_improved_snail();
	integer vindx;
    localparam top=15;
	logic a;
	logic clk, reset;
	logic y, y_exp;
	logic[1:0] vector_in[0 : top-1];
	improved_snail dut(.a(a), .clk(clk), .reset(reset), .y(y));

	initial begin
		$readmemb("input_improved_snail.txt", vector_in);
		$dumpfile("waveform_improved_snail.vcd");
		$dumpvars(0, tb_improved_snail);
		vindx = 0;
		reset = 1; #15; reset = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{a, y_exp} = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (~reset) begin
 			if (y !== y_exp) begin
				$display("Failed at line %d : input %b output %b", (vindx+1), a, y);
			end
			vindx++;
			if (vindx>=top) begin
				$display("Test finished");
				$finish;
			end
		end
	end
endmodule
