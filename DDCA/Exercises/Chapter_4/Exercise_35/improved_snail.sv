module improved_snail
	(input logic a, 
	input logic clk, reset,
	output logic y);

	typedef enum logic[2:0] {S0, S1, S2, S3, S4} statetype;
	statetype state, nextstate;

	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			state <= S0;
		else
			state <= nextstate;
	end

	always_comb begin
		case (state)
			S0 : if (a) nextstate = S1;
				else nextstate = S0;
			S1 : if (a) nextstate = S2;
				else nextstate = S0;
			S2 : if (a) nextstate = S4;
				else nextstate = S3;
			S3 : if (a) nextstate = S1;
				else nextstate = S0;
			S4 : if (a) nextstate = S4;
				else nextstate = S3;
            default: nextstate = S0;
		endcase
	end

	assign y = ((state == S4 && a == 1'b0) || (state == S3 && a == 1'b1)) ? 1'b1 : 1'b0;
endmodule
