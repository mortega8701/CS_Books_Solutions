module sign_extended #(parameter N=4, M=8)
    (input logic[N-1:0] a,
    output logic[M-1:0] y);

    assign y = {{(M-N){a[N-1]}}, a[N-1:0]};
endmodule
