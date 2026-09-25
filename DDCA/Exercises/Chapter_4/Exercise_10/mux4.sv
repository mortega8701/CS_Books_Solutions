module mux4
    (input logic[1:0] sel,
    input logic d3, d2, d1, d0,
    output logic y);

    always_comb begin
        case(sel)
            2'b11: y = d3;
            2'b10: y = d2;
            2'b01: y = d1;
            2'b00: y = d0;
            default: y = 1'bx;
        endcase
    end
endmodule
