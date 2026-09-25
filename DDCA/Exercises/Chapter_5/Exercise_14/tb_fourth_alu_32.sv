module tb_fourth_alu_32();
    localparam vindx = 12;
	logic[31:0] a, b;
    logic[2:0] control;
	logic[31:0] result, result_exp;
    logic[98:0] vector_in[0 : vindx - 1];

	fourth_alu_32 dut(.a(a), .b(b), .control(control), .result(result));

	initial begin
        $readmemh("input_fourth_alu_32.txt", vector_in);
        $dumpfile("waveform_tb_fourth_alu_32.vcd");
        $dumpvars(0, tb_fourth_alu_32);
        for(int i=0; i<vindx; i++) begin
            {control, a, b, result_exp} = vector_in[i]; #10;
            assert 
                (result === result_exp) 
            else 
                $error("Failed at line %d : a=%h, b=%h, control=%b, result=%h", (i+1), a, b, control, result);
        end
        $finish;
	end
endmodule
