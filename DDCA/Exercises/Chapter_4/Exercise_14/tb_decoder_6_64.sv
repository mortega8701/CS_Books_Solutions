module tb_decoder_6_64();
	logic[5:0] a;
	logic[63:0] y, y_exp;
	decoder_6_64 dut(.a(a), .y(y));
	initial
	begin
		$dumpfile("waveform_decoder_6_64.vcd");
		$dumpvars(0, tb_decoder_6_64);
		for (integer i=0; i < 64; i++)
		begin
			a = i[5:0];
			y_exp = 64'b0;
			y_exp[i] = 1'b1;
			#10;
			assert (y === y_exp) else $error("Failed at line %d : input %b output %b", (i+1), a, y);
		end
	end
endmodule
