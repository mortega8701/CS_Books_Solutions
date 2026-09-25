module tb_prefix_adder();
    localparam N=4;
    logic[2**N-1:0] a, b, s, s_exp;
    logic cin, cout, cout_exp;
    prefix_adder #(N) dut(.a(a), .b(b), .cin(cin), .s(s), .cout(cout));
    initial begin
		$dumpfile("waveform_prefix_adder.vcd");
		$dumpvars(0, tb_prefix_adder);
    end

    always begin
        for (integer i=0; i<=50; i++) begin
            a <= {$urandom}[2**N-1:0];
            b <= {$urandom}[2**N-1:0];
            cin <= {$random}[0];
            #10;
            {cout_exp, s_exp} = a + b + {{2**N-1{1'b0}}, cin};
            if(s !== s_exp || cout !== cout_exp) begin
                $display("Failed test at %d: a=%h, b=%h, cin=%b, s=%h, s_exp=%h, cout=%b, cout_exp=%b", (i+1), a, b, cin, s, s_exp, cout, cout_exp);
            end
        end
        $finish;
    end
endmodule
