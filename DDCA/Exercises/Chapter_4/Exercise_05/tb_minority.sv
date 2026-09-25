module tb_minority();
    localparam vindx = 8;
    logic a, b, c;
    logic y, y_exp;
    logic[3:0] vector_in[0 : vindx - 1];
    minority dut(.a(a), .b(b), .c(c), .y(y));
    initial
    begin
        $readmemb("input_minority.txt", vector_in);
        $dumpfile("waveform_minority.vcd");
        $dumpvars(0, tb_minority);
        for (integer i=0; i < vindx; i++)
        begin
            {a, b, c, y_exp} = vector_in[i]; #10;
            assert (y === y_exp) else $error("Failed at line %d: input %b output %b", (i+1), {a,b,c}, y);
        end
    end
endmodule
