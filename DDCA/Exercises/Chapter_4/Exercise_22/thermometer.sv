module thermometer
	#(parameter N = 3) 
	(input logic[N-1:0] a,
	output logic[2**N-1:0] y);

	always_comb begin
		y = 'b0;
		for(integer i = {{32-N{1'b0}}, a}; i >= 0; i--) begin
			y[i] = 1'b1;
		end
	end 
endmodule
