module tb_left_shift_2bit();
    localparam vindx = 3;
	logic[31:0] a;
	logic[31:0] y, y_exp;
    logic[63:0] vector_in[0 : vindx - 1];

	left_shift_2bit dut(.a(a), .y(y));

	initial begin
        $readmemh("input_left_shift_2bit.txt", vector_in);
        $dumpfile("waveform_tb_left_shift_2bit.vcd");
        $dumpvars(0, tb_left_shift_2bit);
        for(int i=0; i<vindx; i++) begin
            {a, y_exp} = vector_in[i]; #10;
            assert 
                (y === y_exp)
            else 
                $error("Failed at line %d : a=%h, y=%h", (i+1), a, y);
        end
        $finish;
	end
endmodule
