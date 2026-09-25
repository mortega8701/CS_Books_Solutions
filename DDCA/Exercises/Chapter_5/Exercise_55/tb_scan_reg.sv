module tb_scan_reg();
    integer vindx;
    localparam top = 6;
    logic[3:0] d;
    logic clk, test, sin;
    logic[3:0] q, q_exp;
    logic sout, sout_exp;
    logic[10:0] vector_in[0 : top - 1];

	scan_reg #(4) dut(.clk(clk), .d(d), .sin(sin), .test(test), .q(q), .sout(sout));

	initial begin
        $readmemb("input_scan_reg.txt", vector_in);
        $dumpfile("waveform_scan_reg.vcd");
        $dumpvars(0, tb_scan_reg);
        vindx=0;
	end

    always begin
        clk = 0; #10;
        clk = 1; #10;
    end

    always @(posedge clk) begin
        {d, sin, test, q_exp, sout_exp} = vector_in[vindx];
    end

    always @(negedge clk) begin
        assert 
            (q === q_exp && sout === sout_exp)
        else 
            $error("Failed at line %d : d=%b, q=%b, (sin, sout) = %b", vindx, d, q, {sin, sout});
        vindx++;
        if (vindx >= top) begin
            $finish;
        end
    end
endmodule
