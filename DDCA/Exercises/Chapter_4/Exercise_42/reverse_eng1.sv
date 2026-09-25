module reverse_eng1
	(input logic x,
	input logic clk, reset,
	output logic q);

	typedef enum logic[1:0] {S0, S1, S2, S3} statetype;

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
			S0 : if (x) nextstate = S3;
				else if (~x) nextstate = S1;
				else nextstate = S0;
			S1 : if (x) nextstate = S2;
				else if (~x) nextstate = S0;
				else nextstate = S1;
			S2 : nextstate = S1;
			S3 : nextstate = S1;
		endcase
	end	

	assign q = (state == S1 || state == S2 || state == S3) ? 1'b1 : 1'b0;
endmodule
