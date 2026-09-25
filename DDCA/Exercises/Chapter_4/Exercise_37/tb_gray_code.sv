module tb_gray_code();
	integer vindx;
    localparam top=8;
	logic clk, reset;
	logic[2:0] y, y_exp;
	logic[2:0] vector_in[0 : top-1];
	gray_code dut(.clk(clk), .reset(reset), .y(y));

	initial begin
		$readmemb("input_gray_code.txt", vector_in);
		$dumpfile("waveform_gray_code.vcd");
		$dumpvars(0, tb_gray_code);
		vindx = 0;
		reset = 1; #15; reset = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		y_exp = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (~reset) begin
 			if (y !== y_exp) begin
				$display("Failed at line %d : output %b", (vindx+1), y);
			end
			vindx++;
			if (vindx>top) begin
				$display("Test finished");
				$finish;
			end
		end
	end
endmodule
