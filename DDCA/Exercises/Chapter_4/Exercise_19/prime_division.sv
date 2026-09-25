module prime_division
    (input logic[3:0] a,
    output logic p, d);

    always_comb begin
        case (a)
            4'b0000 : {p, d} = 2'b01;
            4'b0001 : {p, d} = 2'b00;
            4'b0010 : {p, d} = 2'b10;
            4'b0011 : {p, d} = 2'b11;
            4'b0100 : {p, d} = 2'b00;
            4'b0101 : {p, d} = 2'b10;
            4'b0110 : {p, d} = 2'b01;
            4'b0111 : {p, d} = 2'b10;
            4'b1000 : {p, d} = 2'b00;
            4'b1001 : {p, d} = 2'b01;
            4'b1010 : {p, d} = 2'b00;
            4'b1011 : {p, d} = 2'b10;
            4'b1100 : {p, d} = 2'b01;
            4'b1101 : {p, d} = 2'b10;
            4'b1110 : {p, d} = 2'b00;
            4'b1111 : {p, d} = 2'b01;
            default : {p, d} = 2'bxx;
        endcase
    end
endmodule
