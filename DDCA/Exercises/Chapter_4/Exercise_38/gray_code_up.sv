module gray_code_up
	(input logic up,
	input logic clk, reset,
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
			S0 : if (up) nextstate = S1;
				else nextstate = S7;
			S1 : if (up) nextstate = S2;
				else nextstate = S0;
			S2 : if (up) nextstate = S3;
				else nextstate = S1;
			S3 : if (up) nextstate = S4;
				else nextstate = S2;
			S4 : if (up) nextstate = S5;
				else nextstate = S3;
			S5 : if (up) nextstate = S6;
				else nextstate = S4;
			S6 : if (up) nextstate = S7;
				else nextstate = S5;
			S7 : if (up) nextstate = S0;
				else nextstate = S6;
		endcase
	end

	assign y = state;
endmodule
