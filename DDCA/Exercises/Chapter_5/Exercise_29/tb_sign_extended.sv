module tb_sign_extended();
    localparam vindx = 16;
	logic[3:0] a;
	logic[7:0] y, y_exp;
    logic[11:0] vector_in[0 : vindx - 1];

	sign_extended #(4, 8) dut(.a(a), .y(y));

	initial begin
        $readmemb("input_sign_extended.txt", vector_in);
        $dumpfile("waveform_tb_sign_extended.vcd");
        $dumpvars(0, tb_sign_extended);
        for(int i=0; i<vindx; i++) begin
            {a, y_exp} = vector_in[i]; #10;
            assert 
                (y === y_exp) 
            else 
                $error("Failed at line %d : a=%b, y=%b", (i+1), a, y);
        end
        $finish;
	end
endmodule
