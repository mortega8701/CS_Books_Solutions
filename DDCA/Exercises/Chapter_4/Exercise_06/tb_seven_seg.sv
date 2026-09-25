module tb_seven_seg();
    localparam vindx = 16;
    logic[3:0] data;
    logic[6:0] seg, seg_exp;
    logic[10:0] vector_in[0 : vindx - 1];
    seven_seg dut(.data(data), .seg(seg));
    initial
    begin
        $readmemb("input_seven_seg.txt", vector_in);
        $dumpfile("waveform_seven_seg.vcd");
        $dumpvars(0, tb_seven_seg);
        for (integer i=0; i < vindx; i++)
        begin
            {data, seg_exp} = vector_in[i]; #10;
            assert (seg === seg_exp) else $error("Failed at line %d : input %b output %b", (i+1), data, seg);
        end
    end
endmodule
