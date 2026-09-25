module tb_xor4();
    localparam vindx = 16;
    logic[3:0] a;
    logic y, y_exp;
    logic[4:0] vector_in[0 : vindx - 1];
    xor4 dut(.a(a), .y(y));
    initial
    begin
        $readmemb("input_xor4.txt", vector_in);
        $dumpfile("waveform_xor4.vcd");
        $dumpvars(0, tb_xor4);
        for (integer i=0; i < vindx; i++)
        begin
            {a, y_exp} = vector_in[i]; #10;
            assert (y === y_exp) else $error("Failed at line %d: input %b output %b", (i+1), a, y);
        end
    end
endmodule
