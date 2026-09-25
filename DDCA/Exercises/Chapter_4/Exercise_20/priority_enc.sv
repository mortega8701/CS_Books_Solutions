module priority_enc 
	(input logic[7:0] a,
	output logic[2:0] y,
	output logic none);

	always_comb begin
        casez (a)
            8'b00000000:
                y = 3'b000;
            8'b00000001:
                y = 3'b000;
            8'b0000001?:
                y = 3'b001;
            8'b000001??:
                y = 3'b010;
            8'b00001???:
                y = 3'b011;
            8'b0001????:
                y = 3'b100;
            8'b001?????:
                y = 3'b101;
            8'b01??????:
                y = 3'b110;
            8'b1???????:
                y = 3'b111;
        endcase
        none = ~|a;
	end
endmodule
