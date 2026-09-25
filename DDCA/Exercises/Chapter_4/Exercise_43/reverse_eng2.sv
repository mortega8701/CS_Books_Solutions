module reverse_eng2
	(input logic a,
	input logic clk, reset,
	output logic q);

	typedef enum logic[1:0] {S0, S1, S2} statetype;

	statetype state, nextstate;

	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= S0;
		end
		else begin
			state <= nextstate;
		end
	end

	always_comb begin
		case (state)
			S0 : if (a) nextstate = S1;
				else if (~a) nextstate = S0;
			S1 : if (a) nextstate = S2;
				else if (~a) nextstate = S0;
			S2 : if (a) nextstate = S2;
				else if (~a) nextstate = S0;
            default : nextstate = S0;
		endcase
	end	

	assign q = (state == S2) ? 1'b1 : 1'b0;
endmodule
