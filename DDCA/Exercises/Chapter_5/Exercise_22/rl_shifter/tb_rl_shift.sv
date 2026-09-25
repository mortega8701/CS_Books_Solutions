module tb_rol_shifter();
    localparam vindx = 12;
	logic[3:0] a;
    logic[1:0] shamt;
	logic[3:0] y, y_exp;
    logic[9:0] vector_in[0 : vindx - 1];

    rl_shifter dut(.a(a), .shamt(shamt), .y(y));

	initial begin
        $readmemb("input_rl_shift.txt", vector_in);
        $dumpfile("waveform_tb_rl_shift.vcd");
        $dumpvars(0, tb_rl_shifter);
        for(int i=0; i<vindx; i++) begin
            {a, shamt, y_exp} = vector_in[i]; #10;
            assert 
                (y === y_exp) 
            else 
                $error("Failed at line %d : a=%b, shamt=%b, y=%b", (i+1), a, shamt, y);
        end
        $finish;
	end
endmodule
