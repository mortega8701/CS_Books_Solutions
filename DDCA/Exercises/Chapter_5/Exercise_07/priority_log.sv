/* verilator lint_off UNOPTFLAT */
module priority_log #(parameter N=3)
    (input logic [2**N-1:0] a, 
    output logic [N-1:0] y);

    genvar i, j;

    logic [2**N-1:0] gen_pref[N:0];
    logic [2**N-1:0] enc_layer;
    logic [2**N-1:0] enc_mask[N-1:0];

    generate
        assign gen_pref[0] = ~a;

        for (i=1; i<N+1; i++) begin
            for (j=0; j<2**N; j++) begin
                if (j%2**i <= 2**(i+1) && j%2**i >= 2**(i-1)) begin
                    assign gen_pref[i][j] = gen_pref[i-1][j];
                    assign enc_mask[i-1][j] = 1'b1;
                end
                else begin
                    assign gen_pref[i][j] = gen_pref[i-1][j] & gen_pref[i-1][j-(j%(2**i))+(2**(i-1))];
                    assign enc_mask[i-1][j] = 1'b0;
                end
            end
        end

        for (j=0; j<2**N-1; j++) begin
            assign enc_layer[j] = a[j] & gen_pref[N][j+1];
        end

        assign enc_layer[2**N-1] = a[2**N-1];

        for (i=0; i<N; i++) begin
            assign y[i] = | (enc_layer & enc_mask[i]);
        end
    endgenerate
endmodule
