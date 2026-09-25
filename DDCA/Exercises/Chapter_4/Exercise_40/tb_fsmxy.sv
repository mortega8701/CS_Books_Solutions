module tb_fsmxy();
	integer vindx;
    localparam top=10;
	logic a;
	logic clk, reset;
	logic x, x_exp, y, y_exp;
	logic[2:0] vector_in[0 : top-1];
	fsmxy dut(.a(a), .clk(clk), .reset(reset), .x(x), .y(y));

	initial begin
		$readmemb("input_fsmxy.txt", vector_in);
		$dumpfile("waveform_fsmxy.vcd");
		$dumpvars(0, tb_fsmxy);
		vindx = 0;
		reset = 1; #15; reset = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{a, x_exp, y_exp} = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (~reset) begin
 			if (x !== x_exp && y !== y_exp) begin
				$display("Failed at line %d : input %b output %b", (vindx+1), a, {x, y});
			end
			vindx++;
			if (vindx>=top) begin
				$display("Test finished");
				$finish;
			end
		end
	end
endmodule
