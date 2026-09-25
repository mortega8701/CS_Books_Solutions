module fsmxy 
	(input logic a,
	input logic clk, reset,
	output logic x, y);

	typedef enum logic[1:0] {S0, S1, S2, S3} statetypeX;
	typedef enum logic[1:0] {T0, T1, T2} statetypeY;

	statetypeX stateX, nextstateX;
	statetypeY stateY, nextstateY;

	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			stateX <= S0;
			stateY <= T0;
		end
		else begin
			stateX <= nextstateX;
			stateY <= nextstateY;
		end
	end

	always_comb begin
		case (stateX)
			S0 : if (a) nextstateX = S1;
				else nextstateX = S0;
			S1 : if (a) nextstateX = S2;
				else nextstateX = S1;
			S2 : if (a) nextstateX = S3;
				else nextstateX = S2;
			S3 : nextstateX = S3;
		endcase
		case (stateY)
			T0 : if(a) nextstateY = T1;
				else nextstateY = T0;
			T1 : if(a) nextstateY = T2;
				else nextstateY = T0;
			T2 : if(a) nextstateY = T2;
				else nextstateY = T0;
            default: nextstateY = T0;
		endcase
	end	

	assign x = (stateX == S3) ? 1'b1 : 1'b0;
	assign y = (stateY == T2) ? 1'b1 : 1'b0;
endmodule
