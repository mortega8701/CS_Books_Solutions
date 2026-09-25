module tb_decoder_2_4();
	localparam vindx = 4;
	logic[1:0] a;
	logic[3:0] y, y_exp;
	logic[5:0] vector_in[0 : vindx - 1];
	decoder_2_4 dut(.a(a), .y(y));
	initial
	begin
		$readmemb("input_decoder_2_4.txt", vector_in);
		$dumpfile("waveform_decoder_2_4.vcd");
		$dumpvars(0, tb_decoder_2_4);
		for (integer i=0; i < vindx; i++)
		begin
			{a, y_exp} = vector_in[i]; #10;
			assert (y === y_exp) else $error("Failed at line %d : input %b output %b", (i+1), a, y);
		end
	end
endmodule
