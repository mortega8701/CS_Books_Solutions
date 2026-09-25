module tb_thermometer();
	localparam vindx = 8;
	logic[2:0] a;
	logic[7:0] y, y_exp;
	logic[10:0] vector_in[0 : vindx - 1];
	thermometer dut(.a(a), .y(y));
	initial
	begin
		$readmemb("input_thermometer.txt", vector_in);
		$dumpfile("waveform_thermometer.vcd");
		$dumpvars(0, tb_thermometer);
		for (integer i=0; i < vindx; i++)
		begin
			{a, y_exp} = vector_in[i]; #10;
			assert (y === y_exp) else $error("Failed at line %d : input %b output %b", (i+1), a, y);
		end
	end
endmodule
