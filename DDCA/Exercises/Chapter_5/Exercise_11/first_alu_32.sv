module first_alu_32
    (input logic[31:0] a,
    input logic[31:0] b,
    input logic[1:0] control,
    output logic[31:0] result);

    logic[31:0] sum;
    
    always_comb begin
        sum = a+((control[0]==1)?~b:b)+{31'b0,control[0]};
        case (control)
            2'b00 : result = sum;
            2'b01 : result = sum;
            2'b10 : result = a & b;
            2'b11 : result = a | b;
        endcase
    end
endmodule
