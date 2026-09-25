module decoder_6_64
	(input logic[5:0] a,
	output logic[63:0] y);

	logic[11:0] layer;
	logic[63:0] gen_struct;
	genvar i, j, k;
	decoder_2_4 dec2(.a(a[5:4]), .y(layer[11:8]));
	decoder_2_4 dec1(.a(a[3:2]), .y(layer[7:4]));
	decoder_2_4 dec0(.a(a[1:0]), .y(layer[3:0]));

	generate
		for(i=8; i<12; i++) begin
			for(j=4; j<8; j++) begin
				for(k=0; k<4; k++) begin
					assign gen_struct[((i-8)*16+(j-4)*4+k)] = layer[i] & layer[j] & layer[k];
				end
			end
		end
	endgenerate

	always_comb begin
		y = gen_struct;
	end
endmodule
