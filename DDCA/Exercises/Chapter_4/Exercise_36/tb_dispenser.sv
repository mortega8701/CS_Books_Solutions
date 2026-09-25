module tb_dispenser();
	integer vindx;
    localparam top=21;
	logic N, D, Q;
	logic clk, reset;
	logic RN, RN_exp, RD, RD_exp, R2D, R2D_exp, DISP, DISP_exp;
	logic[6:0] vector_in[0 : top-1];
	dispenser dut(.N(N), .D(D), .Q(Q), .clk(clk), .reset(reset), .RN(RN), .RD(RD), .R2D(R2D), .DISP(DISP));

	initial begin
		$readmemb("input_dispenser.txt", vector_in);
		$dumpfile("waveform_dispenser.vcd");
		$dumpvars(0, tb_dispenser);
		vindx = 0;
		reset = 1; #15; reset = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{N, D, Q, RN_exp, RD_exp, R2D_exp, DISP_exp}  = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (~reset) begin
 			if (RN !== RN_exp) begin
				$display("Failed RN at line %d : input %b output %b", (vindx+1), {N, D, Q}, RN);
			end
            if (RD !== RD_exp) begin
				$display("Failed RD at line %d : input %b output %b", (vindx+1), {N, D, Q}, RD);
			end
            if (R2D !== R2D_exp) begin
				$display("Failed R2D at line %d : input %b output %b", (vindx+1), {N, D, Q}, R2D);
			end
            if (DISP !== DISP_exp) begin
				$display("Failed DISP at line %d : input %b output %b", (vindx+1), {N, D, Q}, DISP);
			end
			vindx++;
			if (vindx>=top) begin
				$display("Test finished");
				$finish;
			end
		end
	end
endmodule
