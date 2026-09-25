module days_month 
	(input logic[3:0] a,
	output logic y);

	always_comb begin
		case(a)
			4'b0001 : y = 1'b1;
			4'b0010 : y = 1'b0;
			4'b0011 : y = 1'b1;
			4'b0100 : y = 1'b0;
			4'b0101 : y = 1'b1;
			4'b0110 : y = 1'b0;
			4'b0111 : y = 1'b1;
			4'b1000 : y = 1'b1;
			4'b1001 : y = 1'b0;
			4'b1010 : y = 1'b1;
			4'b1011 : y = 1'b0;
			4'b1100 : y = 1'b1;
			default : y = 1'bx;
		endcase
	end
endmodule
