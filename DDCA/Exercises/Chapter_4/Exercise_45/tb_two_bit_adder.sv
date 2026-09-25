module tb_two_bit_adder();
	integer vindx;
    localparam top=33;
	logic[1:0] a, b;
	logic clk, c;
	logic[1:0] s, s_exp;
	logic[6:0] vector_in[0 : top-1];
	two_bit_adder dut(.a(a), .b(b), .c(c), .clk(clk), .s(s));

	initial begin
		$readmemb("input_two_bit_adder.txt", vector_in);
		$dumpfile("waveform_two_bit_adder.vcd");
		$dumpvars(0, tb_two_bit_adder);
		vindx = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{a, b, c, s_exp} = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (s !== s_exp) begin
			$display("Failed at line %d : input a=%b b=%b c=%b output sum=%b", 
                    (vindx+1), a, b, c, s);
		end
		vindx++;
		if (vindx>=top) begin
			$display("Test finished");
			$finish;
		end
	end
endmodule
