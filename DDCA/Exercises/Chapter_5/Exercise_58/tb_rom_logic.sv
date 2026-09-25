module tb_rom_logic();
    localparam vindx = 16;
	logic g, b, u, s;
    logic m, m_exp, v, v_exp, j, j_exp;
    logic[6:0] vector_in[0 : vindx - 1];

	rom_logic dut(.g(g), .b(b), .u(u), .s(s), .m(m), .v(v), .j(j));

	initial begin
        $readmemb("input_rom_logic.txt", vector_in);
        $dumpfile("waveform_rom_logic.vcd");
        $dumpvars(0, tb_rom_logic);
        for(int i=0; i<vindx; i++) begin
            {g, b, u, s, m_exp, v_exp, j_exp} = vector_in[i]; #10;
            assert 
                ({m, v, j} === {m_exp, v_exp, j_exp}) 
            else 
                $error("Failed at line %d : input=%b output=%b", (i+1), {g, b, u, s}, {m, v, j});
        end
        $finish;
	end
endmodule
