module rom_logic(
    input logic g, b, u, s,
    output logic m, v, j
);

    logic[3:0] in_pack;
    logic[2:0] out_pack;
    always_comb begin
        casez (in_pack)
            4'b0000: out_pack = 3'b000;
            4'b0001: out_pack = 3'b000;
            4'b0010: out_pack = 3'b000;
            4'b0011: out_pack = 3'b000;
            4'b0100: out_pack = 3'b001;
            4'b0101: out_pack = 3'b000;
            4'b0110: out_pack = 3'b000;
            4'b0111: out_pack = 3'b110;
            4'b1000: out_pack = 3'b010;
            4'b1001: out_pack = 3'b101;
            4'b1010: out_pack = 3'b000;
            4'b1011: out_pack = 3'b101;
            4'b1100: out_pack = 3'b011;
            4'b1101: out_pack = 3'b101;
            4'b1110: out_pack = 3'b000;
            4'b1111: out_pack = 3'b111;
            default: out_pack = 3'b000;
        endcase
    end
    assign in_pack = {g, b, u, s};
    assign {m, v, j} = out_pack;
endmodule
