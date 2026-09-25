module tb_mux8();
    localparam vindx = 8;
    logic[2:0] sel;
    logic d7, d6, d5, d4, d3, d2, d1, d0;
    logic y, y_exp;
    logic[11:0] vector_in[0 : vindx - 1];
    mux8 dut(.sel(sel), .d7(d7), .d6(d6), .d5(d5), .d4(d4), .d3(d3), .d2(d2), .d1(d1), .d0(d0), .y(y));
    initial
    begin
        $readmemb("input_mux8.txt", vector_in);
        $dumpfile("waveform_mux8.vcd");
        $dumpvars(0, tb_mux8);
        for (integer i=0; i < vindx; i++)
        begin
            {sel, d7, d6, d5, d4, d3, d2, d1, d0, y_exp} = vector_in[i]; #10;
            assert (y === y_exp) else $error("Failed at line %d : input %b output %b", (i+1), sel, y);
        end
    end
endmodule
