module mux8
    (input logic[2:0] sel,
    input logic d7, d6, d5, d4, d3, d2, d1, d0,
    output logic y);

    always_comb begin
        case(sel)
            3'b111: y = d7;
            3'b110: y = d6;
            3'b101: y = d5;
            3'b100: y = d4;
            3'b011: y = d3;
            3'b010: y = d2;
            3'b001: y = d1;
            3'b000: y = d0;
            default: y=1'bx;
        endcase
    end
endmodule
