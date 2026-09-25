module xor4 
    (input logic[3:0] a,
    output logic y);

    always_comb begin
        y = ^a;
    end
endmodule
