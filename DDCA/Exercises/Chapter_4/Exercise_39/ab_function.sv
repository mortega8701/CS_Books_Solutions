module ab_function
	(input a, b,
	input clk, reset,
	output z);

	logic aprev;

	always_ff @(posedge clk, posedge reset) begin
		aprev <= a;
	end

	assign z = b ? (aprev | a) : (aprev & a);
endmodule
