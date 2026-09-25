module tb_priority_enc();
	localparam vindx = 9;
	logic[7:0] a;
	logic[2:0] y, y_exp;
	logic none, none_exp;
	logic[11:0] vector_in[0 : vindx - 1];
	priority_enc dut(.a(a), .y(y), .none(none));
	initial
	begin
		$readmemb("input_priority_enc.txt", vector_in);
		$dumpfile("waveform_priority_enc.vcd");
		$dumpvars(0, tb_priority_enc);
		for (integer i=0; i < vindx; i++)
		begin
			{a, y_exp, none_exp} = vector_in[i]; #10;
			assert 
                (y === y_exp && none === none_exp) 
            else 
                $error("Failed at line %d : input %b output y=%b none=%b", (i+1), a, y, none);
		end
	end
endmodule
