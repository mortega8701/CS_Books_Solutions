module two_bit_adder
	(input logic[1:0] a, b,
	input logic clk, c,
	output logic[1:0] s);

	logic cout1, cout0, reg_c;
	logic[1:0] reg_a, reg_b, s_bef;

	fulladder bit_zero_adder(
        .a(reg_a[0]), 
        .b(reg_b[0]), 
        .cin(reg_c), 
        .s(s_bef[0]), 
        .cout(cout0)
    );

	fulladder bit_one_adder(
        .a(reg_a[1]), 
        .b(reg_b[1]), 
        .cin(cout0), 
        .s(s_bef[1]), 
        .cout(cout1)
    );

	always_ff @(posedge(clk)) begin
		reg_a <= a;
		reg_b <= b;
		s <= s_bef;
		reg_c <= c;
	end
endmodule
