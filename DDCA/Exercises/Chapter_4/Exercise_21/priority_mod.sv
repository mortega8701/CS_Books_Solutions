module priority_mod
	(input logic[7:0] a,
	output logic[2:0] z,
    output logic none);

	always_comb begin
        if((a[7] & a[6])==1'b1)
            z = 3'b110;
        else if(((a[7] | a[6]) & a[5])==1'b1)
            z = 3'b101;
        else if(((a[7] | a[6] | a[5]) & a[4])==1'b1)
            z = 3'b100;
        else if(((a[7] | a[6] | a[5] | a[4]) & a[3])==1'b1)
            z = 3'b011;
        else if(((a[7] | a[6] | a[5] | a[4] | a[3]) & a[2])==1'b1)
            z = 3'b010;
        else if(((a[7] | a[6] | a[5] | a[4] | a[3] | a[2]) & a[1])==1'b1)
            z = 3'b001;
        else
            z = 3'b000;
        
        none = ~|a;
	end
endmodule
