module improved_lights
	(input logic ta, tb, 
	input logic clk, reset,
	output logic[1:0] la, lb);

	typedef enum logic[2:0] {S0, S1, S2, S3, S4, S5} statetype;
	statetype state, nextstate;

	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			state <= S0;
		else
			state <= nextstate;
	end

	always_comb begin
		case (state)
			S0 : if (~ta) nextstate = S1;
				else nextstate = S0;
			S1 : nextstate = S2;
			S2 : nextstate = S3;
			S3 : if (~tb) nextstate = S4;
				else nextstate = S3;
			S4 : nextstate = S5;
			S5 : nextstate = S0;
            default: nextstate = S0;
		endcase
	end

	assign la = (state == S2 || state == S3 || state == S4 || state == S5) ? 2'b10 :
				(state == S1) ? 2'b01 : 2'b00;
	
	assign lb = (state == S0 || state == S1 || state == S2 || state == S5) ? 2'b10 :
				(state == S4) ? 2'b01 : 2'b00;
endmodule
