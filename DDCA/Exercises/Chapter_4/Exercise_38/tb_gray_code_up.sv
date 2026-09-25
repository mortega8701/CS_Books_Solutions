module tb_gray_code_up();
	integer vindx;
    localparam top=16;
	logic up;
	logic clk, reset;
	logic[2:0] y, y_exp;
	logic[3:0] vector_in[0 : 100];
	gray_code_up dut(.up(up), .clk(clk), .reset(reset), .y(y));

	initial begin
		$readmemb("input_gray_code_up.txt", vector_in);
		$dumpfile("waveform_gray_code_up.vcd");
		$dumpvars(0, tb_gray_code_up);
		vindx = 0;
		reset = 1; #15; reset = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{up, y_exp} = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (~reset) begin
 			if (y !== y_exp) begin
				$display("Failed at line %d : input %b output %b", (vindx+1), up, y);
			end
			vindx++;
			if (vindx>=top) begin
				$display("Test finished");
				$finish;
			end
		end
	end
endmodule
