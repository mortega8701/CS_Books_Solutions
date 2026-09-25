/* verilator lint_off UNOPTFLAT */
module prefix_adder #(parameter N=4)
    (input logic [2**N-1:0] a, 
    input logic [2**N-1:0] b, 
    input logic cin, 
    output logic [2**N-1:0] s, 
    output logic cout);

    genvar i, j;

    logic[2**N-1:0] p[N:0];
    logic[2**N-1:0] g[N:0];

    assign p[0][0] = 0;
    assign g[0][0] = cin;

    generate
        for (j=0; j<2**N-1; j++) begin
            assign p[0][j+1] = a[j] | b[j];
            assign g[0][j+1] = a[j] & b[j];
        end

        for(i=1; i<N+1; i++) begin
            for (j=0; j<2**N; j++) begin
                if (j%2**i <= 2**(i+1) && j%2**i >= 2**(i-1)) begin
                    // j-1 are the selected column
                    // (j%(2**i)) set the pattern for power of 2
                    // (2**(i-1)) set offset from the right
                    assign p[i][j] = p[i-1][j] & p[i-1][j-1-(j%(2**i))+(2**(i-1))];
                    assign g[i][j] = g[i-1][j] | p[i-1][j] & g[i-1][j-1-(j%(2**i))+(2**(i-1))];
                end
                else begin
                    assign p[i][j] = p[i-1][j];
                    assign g[i][j] = g[i-1][j];
                end
            end
        end

        for (j=0; j<2**N; j++) begin
            assign s[j] = (a[j] ^ b[j]) ^ g[N][j];
        end

        assign cout = ((a[2**N-1] ^ b[2**N-1]) & g[N][2**N-1]) | (a[2**N-1] & b[2**N-1]);
    endgenerate
endmodule
