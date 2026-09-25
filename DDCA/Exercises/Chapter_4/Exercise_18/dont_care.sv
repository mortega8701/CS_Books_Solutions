module dont_care 
	(input logic a, b, c, d,
	output logic y);

	always_comb begin
		case ({a, b, c, d})
			4'b0000 : y = 1'bx;
			4'b0001 : y = 1'bx;
			4'b0010 : y = 1'bx;
			4'b0011 : y = 1'b0;
			4'b0100 : y = 1'b0;
			4'b0101 : y = 1'bx;
			4'b0110 : y = 1'b0;
			4'b0111 : y = 1'bx;
			4'b1000 : y = 1'b1;
			4'b1001 : y = 1'b0;
			4'b1010 : y = 1'bx;
			4'b1011 : y = 1'b1;
			4'b1100 : y = 1'b1;
			4'b1101 : y = 1'b1;
			4'b1110 : y = 1'bx;
			4'b1111 : y = 1'b1;
		endcase
	end
endmodule
