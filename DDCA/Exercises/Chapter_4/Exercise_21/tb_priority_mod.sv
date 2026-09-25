module tb_priority_mod();
	localparam vindx = 9;
	logic[7:0] a;
	logic[2:0] z, z_exp;
    logic none, none_exp;
	logic[11:0] vector_in[0 : vindx - 1];
	priority_mod dut(.a(a), .z(z), .none(none));
	initial
	begin
		$readmemb("input_priority_mod.txt", vector_in);
		$dumpfile("waveform_priority_mod.vcd");
		$dumpvars(0, tb_priority_mod);
		for (integer i=0; i < vindx; i++)
		begin
			{a, z_exp, none_exp} = vector_in[i]; #10;
			assert 
                (z === z_exp && none === none_exp) 
            else 
                $error("Failed at line %d : input %b output z=%b none=%b", (i+1), a, z, none);
		end
	end
endmodule
