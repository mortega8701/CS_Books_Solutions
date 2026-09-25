module tb_priority_log();
    localparam N=3;
    logic[2**N-1:0] a;
    logic[N-1:0] y, y_exp;
    priority_log #(N) dut(.a(a), .y(y));
    initial begin
		$dumpfile("waveform_priority_log.vcd");
		$dumpvars(0, tb_priority_log);
    end

    always begin
        for (integer i=0; i<50; i++) begin
            a <= {$urandom}[2**N-1:0];
            #10;
            for (integer j=2**N-1; j>0; j--) begin
                if (a[j] == 1'b1) begin
                    y_exp = j[N-1:0];
                    break;
                end
            end
            if(y !== y_exp) begin
                $display("Failed test at %d: a=%h, y=%b, y_exp=%b", (i+1), a, y, y_exp);
            end
        end
        $finish;
    end
endmodule
