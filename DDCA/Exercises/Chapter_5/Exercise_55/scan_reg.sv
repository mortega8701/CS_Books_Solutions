module scan_reg
    #(parameter N=4)
    (input logic[N-1:0] d,
    input logic sin,
    input logic clk,
    input logic test,
    output logic sout,
    output logic[N-1:0] q);

    logic[N-1:0] chain;
    always_ff @(posedge clk) begin
        chain[0] <= (test == 1'b1) ? d[0] : sin;
        for(integer i=1; i<N; i++) begin
            chain[i] <= (test == 1'b1) ? d[i] : chain[i-1];
        end
        sout <= chain[N-1];
        q <= chain;
    end
endmodule
