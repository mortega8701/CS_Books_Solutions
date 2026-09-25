module mealy_diag
	(input logic a, b, 
	input logic clk, reset,
	output logic q);

	typedef enum logic[1:0] {S0, S1, S2} statetype;
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
				else if (~a) nextstate = S0;
			S1 : if (b) nextstate = S2;
				else if (~b) nextstate = S0;
			S2 : if (a & b) nextstate = S2;
				else nextstate = S0;
            default: nextstate = S0;
		endcase
	end

	assign q = (state == S2 & {a, b} == 2'b11);
endmodule
