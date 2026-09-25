module fp_adder
(
    input logic[31:0]  fp0,
    input logic[31:0]  fp1,
    output logic[31:0] out
);

    logic       sign0, sign1;
    logic[7:0]  exp0, exp1;
    logic[23:0] mant0, mant1;

    logic       result_sign;
    logic[7:0]  shift_exp;
    logic[24:0] sum_result;

    always_comb begin
        sign0 = fp0[31];
        exp0  = fp0[30:23];
        mant0 = {1'b1, fp0[22:0]};
        sign1 = fp1[31];
        exp1  = fp1[30:23];
        mant1 = {1'b1, fp1[22:0]};

        if(exp0 > exp1) begin
            shift_exp = exp0 - exp1;
            exp1 >> shitf_exp;
        end
        else begin

        end

        alu_out = alu_op0 + (alu_op1>>shift);

    end
endmodule
