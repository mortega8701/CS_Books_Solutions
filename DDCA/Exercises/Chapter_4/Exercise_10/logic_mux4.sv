module logic_mux4
    (input logic a, b, c,
    output logic y);

    logic d3, d2, d1, d0;
    logic[1:0] sel;

    mux4 mux(.sel(sel), .d3(d3), .d2(d2), .d1(d1), .d0(d0), .y(y));

    always_comb begin
        sel = {a ,c};
        d3 = ~b;
        d2 = ~b;
        d1 = b;
        d0 = ~b;
    end
endmodule
