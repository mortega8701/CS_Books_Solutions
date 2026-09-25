module tb_days_month();
	localparam vindx = 16;
	logic[3:0] a;
	logic y, y_exp;
	logic[4:0] vector_in[0 : vindx - 1];
	days_month dut(.a(a), .y(y));
	initial
	begin
		$readmemb("input_days_month.txt", vector_in);
		$dumpfile("waveform_days_month.vcd");
		$dumpvars(0, tb_days_month);
		for (integer i=0; i < vindx; i++)
		begin
			{a, y_exp} = vector_in[i]; #10;
			assert 
                (y === y_exp) 
            else 
                $error("Failed at line %d : input %b output %b", (i+1), a, y);
		end
	end
endmodule
