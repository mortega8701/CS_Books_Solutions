module tb_controller();
	integer vindx;
    localparam top=7; 
	logic ta, tb, p, r;
	logic clk, reset;
	logic[1:0] la, la_exp, lb, lb_exp;
	logic[7:0] vector_in[0 : top-1];
	controller dut(.ta(ta), .tb(tb), .p(p), .r(r), .clk(clk), .reset(reset), .la(la), .lb(lb));

	initial begin
		$readmemb("input_controller.txt", vector_in);
		$dumpfile("waveform_controller.vcd");
		$dumpvars(0, tb_controller);
		vindx = 0;
		reset = 1; #15; reset = 0;
	end

	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	always @(posedge clk) begin
		{ta, tb, p, r, la_exp, lb_exp} = vector_in[vindx];
	end

	always @(negedge clk) begin
		if (~reset) begin
 			if (la !== la_exp || lb !== lb_exp) begin
				$display("Failed at line %d : input %b output %b", (vindx+1), {ta, tb, p, r}, {la, lb});
			end
			vindx++;
            if (vindx>=top) begin
                $display("Test finished");
                $finish;
			end
		end
	end
endmodule
