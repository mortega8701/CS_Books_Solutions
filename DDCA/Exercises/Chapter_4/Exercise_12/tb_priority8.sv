module tb_priority8();
    localparam vindx = 9;
    logic[7:0] a;
    logic[2:0] y, y_exp;
    logic[10:0] vector_in[0 : vindx - 1];
    priority8 dut(.a(a), .y(y));
    initial
    begin
        $readmemb("input_priority8.txt", vector_in);
        $dumpfile("waveform_priority8.vcd");
        $dumpvars(0, tb_priority8);
        for (integer i=0; i < vindx; i++)
        begin
            {a, y_exp} = vector_in[i]; #10;
            assert (y === y_exp) else $error("Failed at line %d : input %b output %b", (i+1), a, y);
        end
    end
endmodule
