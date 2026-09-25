module dispenser
	(input logic N, D, Q, 
	input logic clk, reset,
	output logic R2D, RD, RN, DISP);

	typedef enum logic[3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9} statetype;
	statetype state, nextstate;

	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			state <= S0;
		else
			state <= nextstate;
	end

	always_latch begin
		case (state)
            S0 : if (Q) nextstate = S5;
				 else if (D) nextstate = S2;
				 else if (N) nextstate = S1;
                 else nextstate = nextstate;
            S1 : if (Q) nextstate = S6;
				 else if (D) nextstate = S3;
				 else if (N) nextstate = S2;
                 else nextstate = nextstate;
            S2 : if (Q) nextstate = S7;
				 else if (D) nextstate = S4;
				 else if (N) nextstate = S3;
                 else nextstate = nextstate;
            S3 : if (Q) nextstate = S8;
				 else if (D) nextstate = S5;
				 else if (N) nextstate = S4;
                 else nextstate = nextstate;
            S4 : if (Q) nextstate = S9;
				 else if (D) nextstate = S6;
				 else if (N) nextstate = S5;
                 else nextstate = nextstate;
            S5 : nextstate = S0;
            S6 : nextstate = S0;
            S7 : nextstate = S0;
            S8 : nextstate = S0;
            S9 : nextstate = S0;
            default: nextstate = nextstate;
		endcase
	end

	assign DISP = (state == S5 || state == S6 || state == S7 || state == S8 || state == S9) ? 1'b1 : 1'b0;
	assign R2D = (state == S9) ? 1'b1 : 1'b0;
	assign RD = (state == S7 || state == S8) ? 1'b1 : 1'b0;
	assign RN = (state == S6 || state == S8) ? 1'b1 : 1'b0;
endmodule
