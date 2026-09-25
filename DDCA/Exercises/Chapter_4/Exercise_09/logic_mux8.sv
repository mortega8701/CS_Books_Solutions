module logic_mux8
    (input logic a, b, c,
    output logic y);

    logic d7, d6, d5, d4, d3, d2, d1, d0;
    logic[2:0] sel;

    mux8 mux(.sel(sel), .d7(d7), .d6(d6), .d5(d5), .d4(d4), .d3(d3), .d2(d2), .d1(d1), .d0(d0), .y(y));

    always_comb begin
        sel = {a ,b ,c};
        {d7, d6, d5, d4, d3, d2, d1, d0} = 8'b00111001;
    end
endmodule
