module rr_shifter
    (input logic[3:0] a,
    input logic[1:0] shamt,
    output logic[3:0] y);
    
    always_comb begin
        case (shamt)
            2'b00 : y = {a[3], a[2], a[1], a[0]};
            2'b01 : y = {a[0], a[3], a[2], a[1]};
            2'b10 : y = {a[1], a[0], a[3], a[2]};
            2'b11 : y = {a[2], a[1], a[0], a[3]};
            default : y = 4'bx;
        endcase
    end
endmodule
