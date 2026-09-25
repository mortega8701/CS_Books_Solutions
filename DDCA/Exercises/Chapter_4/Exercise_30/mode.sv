module mode
	(input logic p, r, 
	input logic clk, reset,
	output logic m);

	typedef enum logic {S0, S1} statetype;
	statetype state, nextstate;

	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			state <= S0;
		else
			state <= nextstate;
	end

	always_comb begin
		case (state)
			S0 : if (p) nextstate = S1;
				else nextstate = S0;
			S1 : if (r) nextstate = S0;
				else nextstate = S1;
		endcase
	end

	assign m = (state == S1) ? 1'b1 : 1'b0;
endmodule
