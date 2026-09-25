module tb_second_alu_32();
    localparam vindx = 10;
	logic[31:0] a, b;
    logic[1:0] control;
	logic[31:0] result, result_exp;
    logic[3:0] flags, flags_exp;
    logic[101:0] vector_in[0 : vindx - 1];

	second_alu_32 dut(.a(a), .b(b), .control(control), .result(result), .flags(flags));

	initial begin
        $readmemh("input_second_alu_32.txt", vector_in);
        $dumpfile("waveform_tb_second_alu_32.vcd");
        $dumpvars(0, tb_second_alu_32);
        for(int i=0; i<vindx; i++) begin
            {control, a, b, result_exp, flags_exp} = vector_in[i]; #10;
            assert 
                (result === result_exp && flags === flags_exp) 
            else 
                $error("Failed at line %d : a=%h, b=%h, control=%b, result=%h, flags=%b", (i+1), a, b, control, result, flags);
        end
        $finish;
	end
endmodule
