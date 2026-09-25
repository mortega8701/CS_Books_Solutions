module twos_complement
    (input logic a, 
    input logic clk, reset, 
    output y);

    typedef enum logic[1:0] {S0, S1, S2, S3} statetype;
    statetype state, nextstate;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= S0;
        end
        else begin
            state <= nextstate;
        end
    end

    always_comb begin
        case (state)
            S0 : if (a) nextstate = S2;
                else if(~a) nextstate = S1;
            S1 : if (a) nextstate = S2;
                else if(~a) nextstate = S1;
            S2 : if (a) nextstate = S3;
                else if(~a) nextstate = S2;
            S3 : if (a) nextstate = S3;
                else if(~a) nextstate = S2;
        endcase
    end

    assign y = (state == S1 || state == S3) ? 1'b0 : (state == S2) ? 1'b1 : 1'bz;
endmodule
