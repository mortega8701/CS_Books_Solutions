module seven_seg 
    (input logic[3:0] data,
    output logic[6:0] seg);

    always_comb begin
        case(data)
            'h0 : seg = 7'b1111110;
            'h1 : seg = 7'b0110000;
            'h2 : seg = 7'b1101101;
            'h3 : seg = 7'b1111001;
            'h4 : seg = 7'b0110011;
            'h5 : seg = 7'b1011011;
            'h6 : seg = 7'b1011111;
            'h7 : seg = 7'b1110000;
            'h8 : seg = 7'b1111111;
            'h9 : seg = 7'b1111011;
            'hA : seg = 7'b1110111;
            'hB : seg = 7'b0011111;
            'hC : seg = 7'b1001110;
            'hD : seg = 7'b0111101;
            'hE : seg = 7'b1001111;
            'hF : seg = 7'b1000111;
        endcase
    end
endmodule
