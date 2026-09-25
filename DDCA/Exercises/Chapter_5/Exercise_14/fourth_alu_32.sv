module fourth_alu_32
    (input logic[31:0] a,
    input logic[31:0] b,
    input logic[2:0] control,
    output logic[31:0] result);

    logic[31:0] sum;
    logic V, cout;
    
    always_comb begin
        sum = a+((control[0]==1)?~b:b)+{31'b0, control[0]};
        V = ~(a[31] ^ b[31] ^ control[0]) & (a[31] ^ sum[31]) & ~control[1];
        case (control)
            3'b000 : result = sum;
            3'b001 : result = sum;
            3'b010 : result = a & b;
            3'b011 : result = a | b;
            3'b101 : result = {31'b0, V ^ sum[31]};
            default : result = 32'bx;
        endcase
    end
endmodule
