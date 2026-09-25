module gray_code
	(input logic clk, reset,
	output logic[2:0] y);

	logic[2:0] state, nextstate;

	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b011;
	parameter S3 = 3'b010;
	parameter S4 = 3'b110;
	parameter S5 = 3'b111;
	parameter S6 = 3'b101;
	parameter S7 = 3'b100;

	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			state <= S0;
		else
			state <= nextstate;
	end

	always_comb begin
		case (state)
			S0 : nextstate = S1;
			S1 : nextstate = S2;
			S2 : nextstate = S3;
			S3 : nextstate = S4;
			S4 : nextstate = S5;
			S5 : nextstate = S6;
			S6 : nextstate = S7;
			S7 : nextstate = S0;
		endcase
	end

	assign y = state;
endmodule
