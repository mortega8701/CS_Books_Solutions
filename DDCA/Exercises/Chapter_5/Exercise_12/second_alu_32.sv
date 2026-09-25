module second_alu_32
    (input logic[31:0] a,
    input logic[31:0] b,
    input logic[1:0] control,
    output logic[31:0] result,
    output logic[3:0] flags);
    
    logic N,Z,C,V;
    logic[31:0] sum;
    logic[32:0] ext_a, ext_b, ext_c;
    logic cout;

    always_comb begin
        ext_a = {a[31],a};
        ext_b = {b[31],b};
        ext_c = {32'b0,control[0]};
        {cout, sum} = ext_a+((control[0]==1)?~ext_b:ext_b)+ext_c;
        case (control)
            2'b00 : result = sum;
            2'b01 : result = sum;
            2'b10 : result = a & b;
            2'b11 : result = a | b;
            default : result = 32'bx;
        endcase
        N = result[31];
        Z = &(~result);
        C = ~control[1] & cout;
        V = ~(a[31] ^ b[31] ^ control[0]) & (a[31] ^ sum[31]) & ~control[1];
        flags = {N,Z,C,V};
    end
endmodule
